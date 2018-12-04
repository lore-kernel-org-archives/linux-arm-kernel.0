Return-Path: <SRS0=gVCq=ON=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF346C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:21:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1A9206B7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hmKFpmBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1A9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Btosub/Qug6OdfhzpvNXwSAQQL93RiCGvsTqHGqn0Sc=; b=hmKFpmBDCltCIH
	y5VJ/Q7olwSziEGi1Fg/z4q82U255BJ+LoNhtqcAl+hmRGM4S17sdPenAZHrdert8I7CaIfVAyvLO
	CehXYcmqAmXmKZZjKr+30rZjg/b1+KzmoVDbr5DjtTZeKBHGLJZ8OPhPaN/cNUaUN95cFai1f7FwZ
	G86CLPMr5Z6bM+IEj09/ttaL5oFszocjoxJE1LX6Tq9H8iOQdRgpAzG/jzRGffBhfa/T13xVi8rSg
	h3rzifIT5wElW+PRQuOQ5xDq6UlPn7PPqCnR7GMf9ENvfYOG7oUrqeAVmQ6kZYvvmyDtlXi/cEGTD
	duRNnjacnk6aW9XLk4SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUBZL-0006rd-TW; Tue, 04 Dec 2018 14:20:59 +0000
Received: from gloria.sntech.de ([185.11.138.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUBVL-0001Px-Op; Tue, 04 Dec 2018 14:17:02 +0000
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa
 (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256) (Exim 4.89)
 (envelope-from <heiko@sntech.de>)
 id 1gUBUx-0001AO-R7; Tue, 04 Dec 2018 15:16:27 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
Date: Tue, 04 Dec 2018 15:16:27 +0100
Message-ID: <3170130.k0DT9deCHj@phil>
In-Reply-To: <20181203213223.16986-25-robh@kernel.org>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-25-robh@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181204_061652_524814_09220738 
X-CRM114-Status: GOOD (  15.35  )
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Grant Likely <grant.likely@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Am Montag, 3. Dezember 2018, 22:32:13 CET schrieb Rob Herring:
> Convert Rockchip SoC bindings to DT schema format using json-schema.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> new file mode 100644
> index 000000000000..3d30ec9adcd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -0,0 +1,251 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/rockchip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip platforms device tree bindings
> +
> +maintainers:
> +  - Beniamino Galvani <b.galvani@gmail.com>

# scripts/get_maintainer.pl -f Documentation/devicetree/bindings/arm/rockchip.txt

doesn't list Beniamino at all and he hasn't been active on Rockchip stuff
for a number of years, so I'm not really sure where this mention as
maintainer comes from.


> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - amarula,vyasa-rk3288
> +              - asus,rk3288-tinker
> +              - asus,rk3288-tinker-s
> +              - radxa,rock2-square
> +              - chipspark,popmetal-rk3288
> +              - netxeon,r89
> +              - firefly,firefly-rk3288
> +              - firefly,firefly-rk3288-beta
> +              - firefly,firefly-rk3288-reload
> +              - mqmaker,miqi
> +              - rockchip,rk3288-fennec
> +          - const: rockchip,rk3288

[...]

> +      - items:
> +          - enum:
> +              - firefly,firefly-rk3399
> +              - firefly,roc-rk3399-pc
> +              - pine64,rockpro64
> +              - rockchip,rk3399-evb
> +              - rockchip,rk3399-sapphire
> +              - rockchip,rk3399-sapphire-excavator
> +              - tsd,rk3399-q7-haikou
> +              - vamrs,ficus
> +              - vamrs,rock960 # 96boards RK3399 Rock960 (ROCK960 Consumer Edition)
> +          - const: rockchip,rk3399


as said before, loosing the description of the boards that get thrown 
into one listing really decreases the usability a lot.

Best example is maybe the rk3399 rock960, where the consumer-edition
board is actually named "ficus" and the description actually brings the
connection to the product-name.

So here it may increase the machine-readability but definitly descreases
the human readability of the file itself.

I guess just using the format that all the Google-boards got for all boards
would just be easiest, so for example the rock960 also would just become:

      - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
        items:
          - const: vamrs,ficus
          - const: rockchip,rk3399

      - description: 96boards RK3399 Ficus (ROCK960 Consumer Edition)
        items:
          - const: vamrs,rock960
          - const: rockchip,rk3399


Looking at other socs, this is likely similar there. Like on Mediatek
all the MT67xx eval boards loose the mapping to the
socs marketing name "Helio Foobar" when the description is gone,
which could've been helpful for people reading the binding.


Heiko


> +      - description: Google Bob (Asus Chromebook Flip C101PA)
> +        items:
> +          - const: google,bob-rev13
> +          - const: google,bob-rev12
> +          - const: google,bob-rev11
> +          - const: google,bob-rev10
> +          - const: google,bob-rev9
> +          - const: google,bob-rev8
> +          - const: google,bob-rev7
> +          - const: google,bob-rev6
> +          - const: google,bob-rev5
> +          - const: google,bob-rev4
> +          - const: google,bob
> +          - const: google,gru
> +          - const: rockchip,rk3399





_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
