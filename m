Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCACC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:37:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694812084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ka1AcApo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="q62qYOCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694812084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q+yNzPessVKxsYXwT41yfMkW+mz2THRwjJeX2M7Ueko=; b=ka1AcApoG/hTRU
	FkFRbGf3iKheidkC83gR7Qk9yrN48Wpm862vHxP7JVNgt6ufLX9exdC1nH/Mr1LbdB9mQ0flghCCK
	mfiJQe1Rfxi33ZA009qyCqedqCilcFNqQEoQ0SCYBZRy76tF6XhojRp4i1Oe7R48FStKr+SLrzfgb
	U4NG/s+dT7CEJazmYMXK7i9kh0d6JENRMBrhHYeJy3WEZoCNxmvo99GQczQIbxbtJmQoDKCpvPJuR
	73EoIyVtxw74I4aknwNV5hdgvoOIllagq2l2W2rgI6T9S+I2+Mw8AJ+ftGbjOjvm8WAZaLzjGGK/v
	GdAucuNPXqWeezDrRREA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYoOc-0004Hp-3j; Mon, 17 Dec 2018 08:37:02 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYoOZ-0004HE-9W
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 08:37:00 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id DA57825B7CF;
 Mon, 17 Dec 2018 19:36:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545035805; bh=t7G4wx0VP1azrvPhyuUCYC7/nszmJIXCuH2rnTKM2TM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q62qYOCPVWmmfUP6/dRjxDLZKn90PXPb7uslxT+fq+6GfexOF7aA2mcxkxQ6kSpFp
 fBI0RTcdSTC4tpH6S8G+u9DCk0C230bmE7oLJAnUdbDiE3FG/1SRHEc5KFfIcABtMz
 E+6wqDcKgbtR2c6oAIv1QmX1JT05jnr92QBeyZWA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 7D1E19402FB; Mon, 17 Dec 2018 09:36:42 +0100 (CET)
Date: Mon, 17 Dec 2018 09:36:42 +0100
From: Simon Horman <horms@verge.net.au>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
Message-ID: <20181217083642.6s34yp6dh6k56iie@verge.net.au>
References: <20181214115650.12443-2-horms+renesas@verge.net.au>
 <874lbdj97x.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <874lbdj97x.wl-kuninori.morimoto.gx@renesas.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_003659_521487_3C8D910A 
X-CRM114-Status: GOOD (  13.90  )
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
Cc: linux-renesas-soc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Dec 17, 2018 at 09:29:25AM +0900, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Enable the scu-simple-card which is used by
> > the R-Car E3 (r8a77990) based Ebisu board.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index f88190463481..b521159f5f33 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -491,6 +491,7 @@ CONFIG_SND_SOC_RT5514=m
> >  CONFIG_SND_SOC_RT5514_SPI=m
> >  CONFIG_SND_SOC_RT5645=m
> >  CONFIG_SND_SIMPLE_CARD=m
> > +CONFIG_SND_SIMPLE_SCU_CARD=m
> >  CONFIG_SND_AUDIO_GRAPH_CARD=m
> >  CONFIG_I2C_HID=m
> >  CONFIG_USB=y
> 
> Is Ebisu board using SIMPLE_SCU_CARD ?
> I guess it is SIMPLE or AUDIO_GRAPH CARD, not SCU_CARD.
> 

Hi Morimoto-san,

Using renesas_defconfig as a base I find that without enabling
CONFIG_SND_SIMPLE_SCU_CARD the following are enabled:

   CONFIG_SND_AUDIO_GRAPH_CARD
   CONFIG_SND_SIMPLE_CARD

But I see:

[   12.209793] ALSA device list:
[   12.212799]   No soundcards found.

With CONFIG_SND_SIMPLE_SCU_CARD also enabled (in the defconfig) I see:

[   14.087191] ALSA device list:
[   14.090195]   #0: rsnd-ak4613



The above tested using renesas-drivers-2018-12-04-v4.20-rc5

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
