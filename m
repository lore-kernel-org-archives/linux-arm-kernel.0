Return-Path: <SRS0=flTa=P5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAA5C2F441
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:57:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DBAF2089F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QSOxyG6o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="RG2WHlst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBAF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+QOuT5/jH9MBXoU6rMoIm9HfZ4XxZsrsCCEVEUWYjNc=; b=QSOxyG6o9sZ8q5
	gvu5wNXcuhY9ATpRqmgdiMQzXxPtHoukNG/rZ1UfHvZIQEk35KuI1AGr4/X1XiAwXn3v5qz4LRoRV
	Tdteu20Eb0f6jblvAJiDGdT9kCpPeurFiEPdjKC4iaGuVX2/R8bbA1bZZPLoqwTq0tJ4rUDjd8/V3
	rat2TBuOvY4YO/ogoO+QpmA0fctrQHyJZSDWBzjXOml0aA1XOYlevowwamwaGqFTJuDecn3amdH8L
	EHZuijWmMLi67p0oca9t7dQ4s6voaXqpbDySFpOMLqH1aQvtW263b5ni8VfOmi4UTRTnoKWgwPm+r
	E8Kddv8v/hNl97050l2A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1glctI-0000sm-E0; Mon, 21 Jan 2019 16:57:40 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glctE-0000sR-JB
 for linux-arm-kernel@lists.infradead.org; Mon, 21 Jan 2019 16:57:37 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 468D225B7CB;
 Tue, 22 Jan 2019 03:57:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548089855; bh=Tl/8ubQHZOi/NcjTHvNSJviBv21dSvSWfHwvQzuFrb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RG2WHlst9zEOEhdVhb+pKIroCI1H1DjynR4Xljl7b+8J7AWbtrJX3bzz8JhgK6ITJ
 FlfO98LV5/glk0Zdh444eWypwwwJuxGc6d/UzUV/MbJohhI0p7R3y8IElCWhnOPWc7
 RdFB3Wg1ErSw3FdGrqEdFMG0gt3Y4EcHAjTO3jhI=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 98A06940459; Mon, 21 Jan 2019 17:57:33 +0100 (CET)
Date: Mon, 21 Jan 2019 17:57:33 +0100
From: Simon Horman <horms@verge.net.au>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190121165733.7jqlhqif3es64i43@verge.net.au>
References: <20190118122536.20000-1-horms+renesas@verge.net.au>
 <20190119222220.GA7266@kunai>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190119222220.GA7266@kunai>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190121_085736_778418_01B79DFB 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: linux-renesas-soc@vger.kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Sat, Jan 19, 2019 at 11:22:20PM +0100, Wolfram Sang wrote:
> On Fri, Jan 18, 2019 at 01:25:36PM +0100, Simon Horman wrote:
> > Enable HS400 of SDHI3 using the corresponding DT property.
> > No further changes are required.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> We might need to find an explanation for the performance numbers,
> nontheless this patch is correct.

Thanks, I think we can queue this up for mainline and I have done so for
v5.1.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
