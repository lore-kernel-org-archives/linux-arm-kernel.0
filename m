Return-Path: <SRS0=6Gta=PZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87593C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3B6205C9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 13:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qHas/B9o";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Bp9TFXIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3B6205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nBiUM4cD6V2n6yju9wtBMsnbJwRYWyItXMjaLI7wyXI=; b=qHas/B9oJLc6sM
	lUtRp28HLQxEzGvS3PiHLZ3snhfsJyqpaIq3AoLDObQ64NRZL/PulD2DF1iQgHC/dybecgsElgl/+
	B0k0/8RroviHNFhsoYY6s+3fHondikMJwKkIbePGTYXl8MIrvawo8RpDAcp0rnlpDyBnp3gx2PC6d
	VZSt/7v/xSSTiBZQR9YiyShxbwlEu04MZcKkU4EpCSF1apESOzmWVAB3vXm9Qzye8YAIWDtomeUSC
	Xr72cMv/kvffYW03z49/QXToWDkBaG5JutOVbrptF1Ba4HisFyLl6GyiO9XzZbl0fZyoRUdIQLTaf
	p/Ea9l72H3tZ03tt6GGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gk7mY-00058W-9Q; Thu, 17 Jan 2019 13:32:30 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gk7mS-000589-1S
 for linux-arm-kernel@lists.infradead.org; Thu, 17 Jan 2019 13:32:25 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 47DE325B7E8;
 Fri, 18 Jan 2019 00:32:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1547731939; bh=SrwTN9nUdFe7u6otWptLLx5CgeHapdULFyiaLhUbxWY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bp9TFXIUM3fmVkAkFQnOT+7JayP/mq0HeJDms4qvTk8/5h0Wlntvizoizz5jwdCRL
 fy+/YSkMDrg6EbdC44orl62y3eXNHCBYQduMAH5Bs66s5i1iNU+I3p3KWy8Md9zEon
 6as8gamPf2mI41aMh+Z2SZbiuK7WQfxE4BQKMny4=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 3B3F3940459; Thu, 17 Jan 2019 14:32:17 +0100 (CET)
Date: Thu, 17 Jan 2019 14:32:17 +0100
From: Simon Horman <horms@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: ebisu: Enable HS400 of
 SDHI3
Message-ID: <20190117133216.sx7rqao73xy3ne7r@verge.net.au>
References: <20190110142833.31577-1-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190110142833.31577-1-horms+renesas@verge.net.au>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_053224_234784_1E7EC8FA 
X-CRM114-Status: UNSURE (   9.21  )
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

[CC Wolfram, Niklas]

On Thu, Jan 10, 2019 at 03:28:33PM +0100, Simon Horman wrote:
> Add SDHI3 UHS pin control and use it when enabling HS200 support
> for SDHI3.
> 
> Based on work by Takeshi Kihara.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Tested on top of renesas-devel-20190110-v5.0-rc1

I would value a review of this patch.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
