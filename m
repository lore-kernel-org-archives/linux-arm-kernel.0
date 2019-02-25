Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDADC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:49:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6672084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="idC3LV0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6672084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BfWwervKou6EMKPyNBznI4pwuxJxYBNXqAJbPB6qwV0=; b=idC3LV0AmFneCS
	70WIJ/o4Lq5VFT1xYyfGIf24SBhJnuf0nEN89xQ/vbIm7GuUxvTP0IU/ENgy9w+yngplnqq9WUWxV
	bX75gYQ+doRfsczpKWa1Lx3V4uvSHhSxJ43Um4hdRR8Frqf5KQmhjIeJvOT6lJyQzkez78rRgWQXu
	q032BQuHao3Ydb73u8XHeXyo9u9aaMkcE4GzGLgj8iUIEU/0G+15WsyRN53m2jCeOLg1l5G7ORcXq
	/NUMaIijQxBLKiLcs2PzIQgivTGPbulO7oy1j5/DIeBaicEyzDiqrdgiKnWsDzip1ZvN0QVfKuGIO
	C654KuUsCLlMsOx8m61Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyCsy-0007AW-Jr; Mon, 25 Feb 2019 09:49:20 +0000
Received: from mail-ua1-f68.google.com ([209.85.222.68])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyCsv-00079i-40
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 09:49:18 +0000
Received: by mail-ua1-f68.google.com with SMTP id f88so7775520uaf.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 01:49:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NKfuUCZhb4a2Hng98YnqtIVsa7vGC3q7Lz/aiPFF+wI=;
 b=e3TTGIpsw0+6jJBWyTDcfhv33nJFD6b6WxxQ7mqp4cy90wpkw8HI2ptI0Qk1BINgns
 J8BXPNYPK0yRGEWM3a8vlpTB6lKdZXw0+LG+4y5yJ2D4eNWwb2aOxC0qI6nkstCuYwi7
 sO6qvM0qli4HvJkamjN8gOtspaIeNANgfCUmXdoxVCaaABEu4xr3isi1h/iDXnK4O+Ow
 ybXQxgRNb+es32IkbHkaK7Fxtqmm7ycBIvHBcOVC4g3sRdRZBstQIX21uFgwRr9IUTA5
 5yidYYVvyZh7fgKIIdMMpyfvHG2WlhqChhmHeMrQ4EwCZnmi+uZGfbvrqXCgyvKpvEiW
 gIog==
X-Gm-Message-State: AHQUAuaQBZZS9FaSs8xDbSmZGXUL05hy7PqGoJo0/WYZTWgjlGd7F0IW
 s678+sF68rWFfCY6BPs76O7IbJoH+jlGn/daMs4=
X-Google-Smtp-Source: AHgI3IYN31feATPUBQnHJZeelRUmXBJp+4R+4EZ9gpGv1bRDG3z+fW83flVqRruT4afOsAh60OpStpzRz83vg8v5VcU=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr8522719uao.20.1551088155503; 
 Mon, 25 Feb 2019 01:49:15 -0800 (PST)
MIME-Version: 1.0
References: <20190225093604.25753-1-horms+renesas@verge.net.au>
In-Reply-To: <20190225093604.25753-1-horms+renesas@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Feb 2019 10:49:04 +0100
Message-ID: <CAMuHMdX-U_y7axw9AHYt7Omj5LzE69FTNy6PNUy4TBbxs3CtRA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: salvator: add dummy 2nd port to
 rcar_sound
To: Simon Horman <horms+renesas@verge.net.au>, rob+dt@kernel.org, 
 Mark Rutland <mark.rutland@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_014917_161203_5280797D 
X-CRM114-Status: GOOD (  17.56  )
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

CC DT

On Mon, Feb 25, 2019 at 10:37 AM Simon Horman
<horms+renesas@verge.net.au> wrote:
> Add dummy 2nd port node to rcar_sound ports node to satisfy dtc
> recommendation that #address-cells / #size-cells is only needed.
>
> This addresses the following warning:
>
> arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
> arch/arm64/boot/dts/renesas/salvator-common.dtsi:703.8-719.4: Warning (graph_child_address): /soc/sound@ec500000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary
>
> This change should not have any run-time effect.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
> Build tested against renesas-devel-20190214-v5.0-rc6
> ---
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> index a225c2457274..20b35991bc17 100644
> --- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> +++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
> @@ -716,6 +716,15 @@
>                                 capture  = <&ssi1 &src1 &dvc1>;
>                         };
>                 };
> +
> +               /* Dummy node to be overriden by board DT
> +                * Satisfies dtc recommendation that
> +                * #address-cells / #size-cells is only needed
> +                * for graph nodes with multiple child nodes.
> +                */
> +               rsnd_port1: port@1 {
> +                       reg = <1>;
> +               };
>         };
>  };

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
