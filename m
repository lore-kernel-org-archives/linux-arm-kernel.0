Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBBC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C6A2082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qZ9Cua/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C6A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=34ozIE35153EqjbrM/VwFitYFChBCu0uYjdGIVqcpMo=; b=qZ9Cua/2K+KvIU
	KbkoO0oUa2i/a23LFqo+A/yLRODvNnGHFfDaQ/8g160VBCtKxtwBZCIua+nNqjRNTTLf7rSE1ur4N
	wEGRt5TDlsvQ5HMtE6VsfLuFerI7zw+HbCOed5XDeI0LNK7GDUaiLe13BeGLcbuUsoYDAQ8K1fApV
	Ofa5jh1gpjW3mS3WSfe4e1TDBagXrgxaA95U3xXfVUDva0DkriySG5bLhJ9wquretXrxPp274sFOn
	MQM93H8jrtYRC4Mhvg/okHqSBVczqVS51StE1OqzkN3OO7xErbzBex/uU1w0Hmkl55W6e7Gpq3bIR
	SHJyFWZH0mvsEep00l7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCEv-0002km-R8; Tue, 04 Dec 2018 15:03:57 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCEm-0002ik-1U
 for linux-arm-kernel@lists.infradead.org; Tue, 04 Dec 2018 15:03:53 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 725BD80D;
 Tue,  4 Dec 2018 07:03:37 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 41DC83F614;
 Tue,  4 Dec 2018 07:03:37 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 9A9951AE0A07; Tue,  4 Dec 2018 15:03:57 +0000 (GMT)
Date: Tue, 4 Dec 2018 15:03:57 +0000
From: Will Deacon <will.deacon@arm.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 0/2] arm64: provide a NEON-accelerated XOR algorithm
 extension
Message-ID: <20181204150357.GA6308@arm.com>
References: <20181204014323.1438-1-liuyun01@kylinos.cn>
 <20181204150124.GA23762@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181204150124.GA23762@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_070348_087378_31FFABB7 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-block@vger.kernel.org, catalin.marinas@arm.com,
 Jackie Liu <liuyun01@kylinos.cn>, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 04, 2018 at 07:01:24AM -0800, Christoph Hellwig wrote:
> Why does this go to linux-block?

FWIW, I'll take this via arm64 so feel free to ignore.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
