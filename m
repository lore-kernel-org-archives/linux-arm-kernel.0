Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E344C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:51:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD872084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I3+BQZK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD872084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HOQsVQvHUqmHNNMLtYpD5fBdub0nyMsp2V6WBWqMwLg=; b=I3+BQZK4wziaDY
	0l9nrA/Zx6MZzU7zs2YmZ3E/IoaKSa09gzoe3iQ9TrJ7ZyAiwFMVAUq+Fth9M4vLyXqIiO9Ykudln
	twcLFTv/k/LWES2ZEQKPTqDOXDW5Ysqb8SiZQNG9wblGVka4bX10BY/76J6VHOA+Oig9dP4gCiMp8
	dMkhLT+pUNzF8A2RxJkm777W6qZqTYVwRbB+oL8TQVx9pa/O2NkLaJega6Jh3Dg17FXMPRL+2z5H4
	iF+gagptdVTOaUfJ9K9haMi5ZUUdjCuqi/ter5bCgzU1tAbeL+KliMYYtqWry+lcp10iHVegSTFDh
	njXkVoJAPgbEgBvjHDIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyCuu-0000bd-H2; Mon, 25 Feb 2019 09:51:20 +0000
Received: from mail-ua1-f66.google.com ([209.85.222.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyCur-0000bB-B4
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 09:51:18 +0000
Received: by mail-ua1-f66.google.com with SMTP id a42so7780261uad.1
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 01:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Eh2CDbnaj99sV25EnYVssSUfplApDG/vTmBWD+P3RLw=;
 b=l03Huw8Klw5cS6tjPgB2eR6h0fgC46oACcDlPJQTJ0qovRhyp6FOguaGP7nXzYWSSs
 gZcBabfOiZ9A9Z7TbIWQ4RFJgp26N0ZSc9+GOpq/R4GD1Ra8MbgqT+dIVsccYXl1DPeW
 ARJgoTyw9ddLXrW9/Egdasa9P9t2OYq5FrErk1cgZdEhGcwOl1jw5nLbdJX+5BSxNpFI
 d3kMSmPj+dY+NPbPq9vJ1MAsNTMHHD8WMNuSEk8LvbVBeAPRIJ/wnOrujVCsJt++T8KB
 ZaBgOaCdmDtFP8K/+k/F1yR1n3vKDr066qXXB5ggO8DR1EY5sIKBsAajQvGPf3o+jR+i
 oQJw==
X-Gm-Message-State: AHQUAuZCUQTxPBdXGp7PFk2vT0IBPI6OgB4+u08cpMza9e6IBzxwGRE4
 UmKpEbAH8KXKu1Nye7pbMAIjpCtrtKCE3AIHxgI=
X-Google-Smtp-Source: AHgI3IYYo2d0Jl+T1lTPrIaRogYDlxuS85qYDSJnfWutRkcvcdf/5t9Ok2LtP5aNR70wDCRZltvocY9D/V7BFx++LRI=
X-Received: by 2002:a67:ead0:: with SMTP id s16mr8266077vso.63.1551088276192; 
 Mon, 25 Feb 2019 01:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20190225093604.25753-1-horms+renesas@verge.net.au>
 <CAMuHMdX-U_y7axw9AHYt7Omj5LzE69FTNy6PNUy4TBbxs3CtRA@mail.gmail.com>
In-Reply-To: <CAMuHMdX-U_y7axw9AHYt7Omj5LzE69FTNy6PNUy4TBbxs3CtRA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Feb 2019 10:51:04 +0100
Message-ID: <CAMuHMdUpWu9HFxgxA6C=Y+OMOfe-cm+fibUgr8r9fVrjW5=p1Q@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: salvator: add dummy 2nd port to
 rcar_sound
To: Simon Horman <horms+renesas@verge.net.au>,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_015117_382872_164F8C06 
X-CRM114-Status: GOOD (  18.77  )
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
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Woops, this time using the Real Rob.

On Mon, Feb 25, 2019 at 10:49 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> CC DT
>
> On Mon, Feb 25, 2019 at 10:37 AM Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add dummy 2nd port node to rcar_sound ports node to satisfy dtc
> > recommendation that #address-cells / #size-cells is only needed.
> >
> > This addresses the following warning:
> >
> > arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> > arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> >
> > This change should not have any run-time effect.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> > ---
> > Build tested against renesas-devel-20190214-v5.0-rc6
> > ---
> >  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > index a225c2457274..20b35991bc17 100644
> > --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> > @@ -716,6 +716,15 @@
> >                                 capture  = <&ssi1 &src1 &dvc1>;
> >                         };
> >                 };
> > +
> > +               /* Dummy node to be overriden by board DT
> > +                * Satisfies dtc recommendation that
> > +                * #address-cells / #size-cells is only needed
> > +                * for graph nodes with multiple child nodes.
> > +                */
> > +               rsnd_port1: port@1 {
> > +                       reg = <1>;
> > +               };
> >         };
> >  };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
