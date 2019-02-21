Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BCAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:48:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4002E2080F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tRL7P8+i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJs2Ul4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4002E2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aQ+qiyly30Ksr5M0Z8rorQYfOOJRyNMTCONj2LbwTBA=; b=tRL7P8+ikdHZBg
	6JFRlMGPs1eWSgWRZP44lAo3kTeENnmhVysykKbTHUX26F5gstxR7OuJhFNW5aNa7R5jAhFTF6P0a
	DsRpuQGG7y4hTZxdKdQE59vGSOGFPeyyLx1NaI42EnQvEOGFcJE25aOm1gt3UuHBQx8RAl4v77osE
	k4NaHyiu2SON1AyBCxecXWnj6QZUanxheNl7Zmx0BhsWHCTw/cSZGMIJbk3SFECfrrAD7IoQ69amf
	6jE4bUnYZMm9hteYBtLls6eZapANwVwSeFp3mEEaeN3VkK90mQZbpbO9qM4YamCiLwgu56xCxgIRP
	5LVkSsB0vtONQq9NNnCA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwwCm-0001lF-8X; Thu, 21 Feb 2019 21:48:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwwCi-0001ke-Mv
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 21:48:30 +0000
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com
 [209.85.222.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4004920836
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 21:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550785708;
 bh=kQRuL8N5WHy6GhFTFJWp6P2zNfvy4xNX1h++zfBQkQY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XJs2Ul4nP3GKGSAvPmFYBIptyKDhurvB34UMMBzqxM1p2Vdb9DdXUy8T3I3IvK1pX
 zbSglGHpS7SEpuw8XFOfbI24G3mBOvLwdQ4T9d4U8b7aKKnOWpLTwda3yyZDnJ5e79
 QdD35TKkG0GqBKBqiDVKWYwoXJhoRCw+8ouHLvDY=
Received: by mail-qk1-f180.google.com with SMTP id y15so76502qki.8
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 13:48:28 -0800 (PST)
X-Gm-Message-State: AHQUAubHlqszHoCbgEhlRxYIi4S/cgjMTlacHPrHdSONFWs+ECZUpDkB
 cDnAKeccUsGecYMPKYMT4+J0aJNJ8LPZGgEdXg==
X-Google-Smtp-Source: AHgI3Iak9qotwMOl0TkSGjzPMg9XCl2TwYNvMb6zhpL4+iKrFOQtzYwFjS8eZgIUvaMqMg9WIMVNv2m6VnuwzzgB2pQ=
X-Received: by 2002:a37:a381:: with SMTP id m123mr557832qke.147.1550785707463; 
 Thu, 21 Feb 2019 13:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20190221154458.23763-1-linus.walleij@linaro.org>
 <20190221154458.23763-27-linus.walleij@linaro.org>
In-Reply-To: <20190221154458.23763-27-linus.walleij@linaro.org>
From: Rob Herring <robh@kernel.org>
Date: Thu, 21 Feb 2019 15:48:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxEu6AhqEXhXSMwSFcfd3oZ2pZMmT_wwZZvvX9e=jUDg@mail.gmail.com>
Message-ID: <CAL_JsqKxEu6AhqEXhXSMwSFcfd3oZ2pZMmT_wwZZvvX9e=jUDg@mail.gmail.com>
Subject: Re: [PATCH 26/30 v2] soc: ixp4xx: Add DT bindings for IXP4xx NPE
To: Linus Walleij <linus.walleij@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_134828_783242_93652A09 
X-CRM114-Status: GOOD (  19.85  )
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
Cc: devicetree@vger.kernel.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 21, 2019 at 9:46 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adds DT bindings for the Intel IXP4xx Network Processing
> Engine (NPE). These are three firmware-executing units found in
> the IXP4xx SoC. These bindings use YAML.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  ...ntel,ixp4xx-network-processing-engine.yaml | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
>
> diff --git a/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
> new file mode 100644
> index 000000000000..8cb136c376fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/intel,ixp4xx-network-processing-engine.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/firmware/intel-ixp4xx-network-processing-engine.yaml#"

firmware? firmware/ is for things like psci, optee, etc. I'm not sure
this fits as it has some sort of h/w interface. Wouldn't networking be
a better fit?

> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel IXP4xx Network Processing Engine
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description: |
> +  On the IXP4xx SoCs, the Network Processing Engine (NPE) is a small
> +  processor that can load a firmware to perform offloading of networking
> +  and crypto tasks. It also manages the MDIO bus to the ethernet PHYs
> +  on the IXP4xx platform. All IXP4xx platforms have three NPEs at
> +  consecutive memory locations. They are all included in the same
> +  device node since they are not independent of each other.
> +
> +properties:
> +  compatible:
> +    oneOf:

oneOf can be dropped.

> +      - items:
> +          - const: intel,ixp4xx-network-processing-engine
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 3

These 2 lines can be dropped. If not specified, they are automatically
added based on how many 'items'.

> +    items:
> +      - description: NPE0 register range
> +      - description: NPE1 register range
> +      - description: NPE2 register range
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    npe@c8006000 {
> +         compatible = "intel,ixp4xx-network-processing-engine";
> +         reg = <0xc8006000 0x1000>, <0xc8007000 0x1000>, <0xc8008000 0x1000>;
> +    };
> --
> 2.20.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
