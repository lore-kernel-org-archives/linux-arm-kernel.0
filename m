Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6286C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971472082B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NymQS+Yb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGadupLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971472082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DTCgANV7Jwloc8eCCFIJ8JfADG9r/rk3LsOIiQezuxY=; b=NymQS+Yb8J5HmB
	TliZimq7sVKULadw3ttfZxaTTF51zNiVWnIejIgEwA9KKqX5F1T9NKN6QzcfIpP8Ym5JuzEsLtfnD
	XB/saFgpGVy8NQ9CfAa9XCe+XszZQf1QAOHoxOZP1nxwNmYziHSChAHUIz4/vy1tSNg2+J3quUgjt
	i42A2M1czedF0JG2Mp/8Gpl1Y8Wvn819FMZmQvMFsJQfelifIH3zhAUzgHsSxdYf5OrGedE1Sbvl7
	drQJ3VZWJKugj5BuWONASwj49vQoGSfbbofOrXcWTKKxma7B8HGGN/1JxFdUZKVw/oygTzUVVbgLg
	RiNjOjJi5XrADBdlwHVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUCFT-0003Ji-Ol; Tue, 04 Dec 2018 15:04:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUCFM-00034b-2T; Tue, 04 Dec 2018 15:04:29 +0000
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DE87D214C1;
 Tue,  4 Dec 2018 15:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543935853;
 bh=HdctKzxhIzA5Gileog4jo6YzMyxJEoW+jk67LM2xECg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=nGadupLmjDAD1bmPQF+j/5LsIOKP+nY5Lg/CDyZmVCPMSWHZNgAwi9UAqKMantj+O
 E1RPWZBeoWACU6pYURhoUVJWZzhvQNfOWPX3DxUp5pLGS4tUmNFEVSPDPGeLGvNYGK
 PvkQE9wphjMKQRbicBAYHj9MkjFfcwd/CDs1jJTE=
Received: by mail-qt1-f169.google.com with SMTP id i7so18316434qtj.10;
 Tue, 04 Dec 2018 07:04:12 -0800 (PST)
X-Gm-Message-State: AA+aEWaFuDq0OQjwTpS5GV1Og7eyLiOrgvACa16uIRNY4zeoyTX2i8vF
 wpzwWdxYoZnnh4eZ+xX+qI2xI/xJ7r3DK7kZKw==
X-Google-Smtp-Source: AFSGD/UxX00JUXYe4WhcTim/duD5eAOZOjhVmC85JiZHnQ/r6zyx7o/gmpM9vKLumEZGa4Jml4vbfXF/3p7lKwQWe4A=
X-Received: by 2002:a0c:e2ca:: with SMTP id t10mr20764932qvl.77.1543935851783; 
 Tue, 04 Dec 2018 07:04:11 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-25-robh@kernel.org> <3170130.k0DT9deCHj@phil>
In-Reply-To: <3170130.k0DT9deCHj@phil>
From: Rob Herring <robh@kernel.org>
Date: Tue, 4 Dec 2018 09:04:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Message-ID: <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
Subject: Re: [PATCH v2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To: "heiko@sntech.de" <heiko@sntech.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_070424_405540_D6BE6D35 
X-CRM114-Status: GOOD (  22.74  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Tue, Dec 4, 2018 at 8:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 3. Dezember 2018, 22:32:13 CET schrieb Rob Herring:
> > Convert Rockchip SoC bindings to DT schema format using json-schema.
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: devicetree@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-rockchip@lists.infradead.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > new file mode 100644
> > index 000000000000..3d30ec9adcd3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -0,0 +1,251 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/rockchip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip platforms device tree bindings
> > +
> > +maintainers:
> > +  - Beniamino Galvani <b.galvani@gmail.com>
>
> # scripts/get_maintainer.pl -f Documentation/devicetree/bindings/arm/rockchip.txt
>
> doesn't list Beniamino at all and he hasn't been active on Rockchip stuff
> for a number of years, so I'm not really sure where this mention as
> maintainer comes from.

git history. get_maintainers.pl had too many cases where I ended up as
the maintainer.

I'll drop him.

> > +  - Heiko Stuebner <heiko@sntech.de>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - amarula,vyasa-rk3288
> > +              - asus,rk3288-tinker
> > +              - asus,rk3288-tinker-s
> > +              - radxa,rock2-square
> > +              - chipspark,popmetal-rk3288
> > +              - netxeon,r89
> > +              - firefly,firefly-rk3288
> > +              - firefly,firefly-rk3288-beta
> > +              - firefly,firefly-rk3288-reload
> > +              - mqmaker,miqi
> > +              - rockchip,rk3288-fennec
> > +          - const: rockchip,rk3288
>
> [...]
>
> > +      - items:
> > +          - enum:
> > +              - firefly,firefly-rk3399
> > +              - firefly,roc-rk3399-pc
> > +              - pine64,rockpro64
> > +              - rockchip,rk3399-evb
> > +              - rockchip,rk3399-sapphire
> > +              - rockchip,rk3399-sapphire-excavator
> > +              - tsd,rk3399-q7-haikou
> > +              - vamrs,ficus
> > +              - vamrs,rock960 # 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> > +          - const: rockchip,rk3399
>
>
> as said before, loosing the description of the boards that get thrown
> into one listing really decreases the usability a lot.

Sorry, I thought I addressed these previous comments.

> Best example is maybe the rk3399 rock960, where the consumer-edition
> board is actually named "ficus" and the description actually brings the
> connection to the product-name.
>
> So here it may increase the machine-readability but definitly descreases
> the human readability of the file itself.
>
> I guess just using the format that all the Google-boards got for all boards
> would just be easiest, so for example the rock960 also would just become:
>
>       - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
>         items:
>           - const: vamrs,ficus
>           - const: rockchip,rk3399
>
>       - description: 96boards RK3399 Ficus (ROCK960 Consumer Edition)
>         items:
>           - const: vamrs,rock960
>           - const: rockchip,rk3399

Sure, you can do this if you like. I prefer the other way as it is a
one line change to add a board. The SoC maintainers can pick whatever
they like. You could split into a file per SoC too if you wanted.

> Looking at other socs, this is likely similar there. Like on Mediatek
> all the MT67xx eval boards loose the mapping to the
> socs marketing name "Helio Foobar" when the description is gone,
> which could've been helpful for people reading the binding.

Generally when we had just 'hello,foobar' with 'Hello Foobar' I
dropped the comment as I didn't think it added much.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
