Return-Path: <SRS0=cUnb=OQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15203C64EB1
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D573120837
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 22:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QgE1H+ai";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="S/sr730Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D573120837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xGsbMQgrshb+7CQK834v5bdNzJvgPKm4LHRfk/7IqHg=; b=QgE1H+aiBhbiV9
	rJZvrdLq/C7uqDn2c/aN29RRDXoK+Al/MiCW4htZQDXnSQubB+DKgKW14MmhrbhErvWIBAgdvxF0z
	0qEmOwqBhJskXGKuXgLMIYpvpKSUNL8I46RQb5Q8sGZtSOb3HvvqVApMRiMo/YEsIujrzZyXTMmF0
	0/KaPST1dXbbpKq/VBOP55ZBzfYxdUU27C0zdJ5z2q0KGK03fhbJv9//8oph+bJMzIn6DWStlH3aS
	7G6HPrm5nePpjCaZran9Bq3fmpIdFp1B1Th6nK1X+o+N8H6P4FLmPDIyOGVWeCdFpyq2xIcK8WlJh
	SoL28oue15ZiBGBGK70w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gVOGv-0000td-Kj; Fri, 07 Dec 2018 22:06:57 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gVOGr-0000aw-Lq
 for linux-arm-kernel@lists.infradead.org; Fri, 07 Dec 2018 22:06:56 +0000
Received: from penelope.horms.nl (unknown [66.60.152.14])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 99CE425B772;
 Sat,  8 Dec 2018 09:06:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1544220397; bh=M8Ob020jX5lYJZXW/ki66JYK1abO4pbbzabeuNZgJPw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S/sr730Yu2umXTV8Qiy4gZfkSzq+1OAV/iC/U2+iHMd/Qs6Rjcd42Gbvzi/2SXN76
 RMKh0bzpgZlsK+t+ZRiu8QJTvIJH6EZykl8pEGkyw/9cbcCBUGD4Ket5XYPSKG+COM
 A8Ny+hWUlvGOlkIdRCIs5hGcqETN4pwVP9AVZQJY=
Received: by penelope.horms.nl (Postfix, from userid 7100)
 id 8F364E21700; Fri,  7 Dec 2018 14:06:36 -0800 (PST)
Date: Fri, 7 Dec 2018 14:06:36 -0800
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] arm64: defconfig: Enable scu-simple-card driver
Message-ID: <20181207220635.v2el5xvwalenm66q@verge.net.au>
References: <cover.1544126077.git.horms+renesas@verge.net.au>
 <595096daf0ac9c1741b6182eb72d636802a21006.1544126077.git.horms+renesas@verge.net.au>
 <CAMuHMdUZSqaW_Vk9GjrtKjRUKdmbFMC5CEswGc_wDWQ-d515hw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUZSqaW_Vk9GjrtKjRUKdmbFMC5CEswGc_wDWQ-d515hw@mail.gmail.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181207_140654_369398_70C1E837 
X-CRM114-Status: GOOD (  16.52  )
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
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 07, 2018 at 09:28:22AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Dec 6, 2018 at 10:58 PM Simon Horman <horms+renesas@verge.net.au> wrote:
> > Enable the scu-simple-card which is used by
> > the R-Car E3 (r8a77990) based Ebisu board.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/configs/defconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> > index f88190463481..9d0b42d96f03 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -491,6 +491,7 @@ CONFIG_SND_SOC_RT5514=m
> >  CONFIG_SND_SOC_RT5514_SPI=m
> >  CONFIG_SND_SOC_RT5645=m
> >  CONFIG_SND_SIMPLE_CARD=m
> > +CONFIG_SND_SIMPLE_SCU_CARD=y
> 
> Shouldn't this be "m"?

Thanks Geert,

I'll look into an incremental update for that.

> 
> >  CONFIG_SND_AUDIO_GRAPH_CARD=m
> >  CONFIG_I2C_HID=m
> >  CONFIG_USB=y
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
