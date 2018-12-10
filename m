Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D65C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D74F820821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XrkIghJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74F820821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2k78GSR0DyQLu8xqDbNZJz11GbGj+UkyDuvHpHni/ZY=; b=XrkIghJ99wPNnJ
	4fhwP52LEZCw8Gu013xU+/DUA+fodcD3QPnrVlTz0ibqP4U/f4Ixm5TgNSD+EwXiyD9mcT+O9vSsQ
	87Y8/XRDCx20V3dlTXQhGMM6Fz3mHYRpshsE7Q7nydnG6c3MSAWAH+z3LjApqbINbkJXFzOslMWc1
	Nb4DQ5Ugs396KWlFoZ/MMBtiwNyb4f9M5IvjAcYuJ0ELpeEyA73YGRz15xMsOePQP+IyJptnOzsbg
	Jw/QOYRbRgYfsEPpCDfYsReSSiYAKrmuuU6+WHmUxUaLChsJglfVlDU4gyA9Du1Qxueg3HKX+lZ5p
	Dk9phCRLKtVpi+e0KkPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWK5J-000083-4u; Mon, 10 Dec 2018 11:50:49 +0000
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWK53-0008Is-9i
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 11:50:34 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF3C615AB;
 Mon, 10 Dec 2018 03:50:18 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com
 (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7BC923F6A8;
 Mon, 10 Dec 2018 03:50:18 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
 id 177CF1AE0CBE; Mon, 10 Dec 2018 11:50:41 +0000 (GMT)
Date: Mon, 10 Dec 2018 11:50:41 +0000
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 00/10] arm64: assembly export cleanup
Message-ID: <20181210115040.GA23485@edgewater-inn.cambridge.arm.com>
References: <20181207180823.36612-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181207180823.36612-1-mark.rutland@arm.com>
User-Agent: Mutt/1.11.1+30 (d10eec459b35) ()
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_035033_336767_9DED6EFA 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 06:08:13PM +0000, Mark Rutland wrote:
> When exporting a C function, we place the EXPORT_SYMBOL() immediately after the
> function definition. Historically we couldn't do this with assembly functions,
> and hence we collected all of these exports in arm64ksyms.c. Over time, this
> has retained redundant includes and exports for items defined in C code.
> 
> For a while now it has been possible to export functions directly from assembly
> files, which is beneficial for ongoing maintenance.
> 
> These patches move the exports from arm64ksyms.c into their relevant assembly
> files, and remove the newly redundant arm64ksyms.c. I've pushed the series to
> my arm64/export-cleanup branch [1] on kernel.org.

Cheers, I've picked this up.

Will

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
