Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2356AC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C7A222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mv03Rzbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7A222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0BG/APJ7D2J3Cvn/CQAC29h/EUaw+MgR/C2gj+gmoP4=; b=Mv03Rzbt+6VawF
	nyTjdWQbZa3ABIz2zWK5dhOlnZ80YU4XLkH4n29kdS/ebRHlGMbPj0dHaNCaaVUhqtPOTl3KhLYhh
	QQ3FKP3cCv8w/H836qxmx1xYN/tlatvAmcX8kMuwo6CGo6vx6f12TvDxZLsIJeOTBGaNnTXgYYaBe
	1E6/hgxRrUxreW/wPmYNP9qCaF5VB6N51tusr5jswivnlFaz41Up5gAJyNM/TJ9PaOvoxRI0EtKTI
	/+Vb0ILKlM/c43mjRoxVHQqsB4ht6FYSJuWdmJL/y9XFgW88AhRLkJIrdy2FXHHGPxUDH8FoPL3w/
	JhY6565UN2Z3N9AkF0fw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuRr-0006ew-Gz; Wed, 13 Feb 2019 13:19:35 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuRn-0006cX-3s; Wed, 13 Feb 2019 13:19:32 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C669A1596;
 Wed, 13 Feb 2019 05:19:30 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3D13F557;
 Wed, 13 Feb 2019 05:19:28 -0800 (PST)
Date: Wed, 13 Feb 2019 13:19:25 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH 1/1] arm64: Use _rcuidle for smp_cross_call() tracepoints
Message-ID: <20190213131924.GD5875@brain-police>
References: <1549969765-3707-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1549969765-3707-1-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_051931_162289_078B9026 
X-CRM114-Status: GOOD (  10.52  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: CC Hwang <cc.hwang@mediatek.com>, wsd_upstream@mediatek.com,
 Catalin Marinas <catalin.marinas@arm.com>, Loda Chou <loda.chou@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Feb 12, 2019 at 07:09:25PM +0800, Mars Cheng wrote:
> fix similar issue for aarch64 as the commit 7c64cc0531fa
> ("arm: Use _rcuidle for smp_cross_call() tracepoints") fixed
> in aarch32

I'm not convinced about this justification. As far as I can tell, the commit
mentioned above fixed a cross-call from the idle path as a result of
ARCH_NEEDS_CPU_IDLE_COUPLED, but this never appears to be selected on arm64
afaict.

Are you actually seeing a problem on arm64 in practice?

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
