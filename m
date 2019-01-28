Return-Path: <SRS0=FIMe=QE=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07994C282C8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE25C20879
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lymeZau4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRT/sqLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE25C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+/6ulzeSmWINJDN56fEyStNOavduj+r0fT+x48fJelQ=; b=lymeZau4emJF8O
	8+rFfWIGKr883gRRpA1CRg6axA8l4tOOuns6gMgVcNQjUx52Iq/2qLHI66p7dJj6+hY5zcD+hUkFt
	WBdFKF/0kv14Eu4D44NC1+bPq5ULvAjCvg4QrfjJFWaYhk/l0i5/I7WhQZgwUmEQdRMFmmP1rr3Y2
	5Vgib5s7w9OLSDkeiTkI2YgWUX7tPFLw4BXOOo9guZWrQ7jG/cm/s1cswKSgo+SKW09wlj35ZVNdF
	94Lo1+YFRbJ5jRExkOaLKBf1flkofPoykcIvtFOnVFBsddwLzKttb2tYE+qUzeDWO0TXnk0LmeFYT
	Tq+s48YKHVGFcWPbEU6A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1go9bC-0002j7-VK; Mon, 28 Jan 2019 16:17:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1go9b9-0002iA-1n
 for linux-arm-kernel@lists.infradead.org; Mon, 28 Jan 2019 16:17:24 +0000
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BA2121925
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548692242;
 bh=l644JXd3NOUX2dUGbeApzXMy9qq3K2AgIt3Ppvs/Aoo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=pRT/sqLNIzGBTR6mG7stPyKDW8agesa+KR/kuTJtS4UncpCimBb1P/rU3UeCHOHdW
 5sp1oEnxtj95pBQmWFopx6/5dm60V7R7rhLm1vvUbvjacPBQ1gCOH1H2MFWyO9SHEc
 aWngiv4DxS0jimivqCpWxbYcJ3XWHE86wxloaiEA=
Received: by mail-qk1-f173.google.com with SMTP id w204so9709776qka.2
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 28 Jan 2019 08:17:22 -0800 (PST)
X-Gm-Message-State: AJcUukcrRwTf1Nsn79VpXV3cSSB/ve46qmcZaSLl72NLcoWKnsrHeH8k
 EzPks8xF5jHdUl7CR8LBdTUqbAz4ORNGbJJqQw==
X-Google-Smtp-Source: ALg8bN5XcP+boaJr0aIBN7CN+8meZI8yn2IkC5Nvgo+5QMSV5wZmJSuh00bE6swT6HqLay+gEtqaz1sUM6G0BACqXe0=
X-Received: by 2002:a37:7682:: with SMTP id r124mr20140647qkc.79.1548692241275; 
 Mon, 28 Jan 2019 08:17:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.ba7411f0c7155d0292b38d3dec698e26b5cc813b.1548687041.git-series.maxime.ripard@bootlin.com>
 <f6b6adf84c58e0de605d0a23dd559fee011f380c.1548687041.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <f6b6adf84c58e0de605d0a23dd559fee011f380c.1548687041.git-series.maxime.ripard@bootlin.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 28 Jan 2019 10:17:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKOyr3nbXozTqBsEAQGw2bPsBGvFpJ_X7S-izdjTWxK=g@mail.gmail.com>
Message-ID: <CAL_JsqKOyr3nbXozTqBsEAQGw2bPsBGvFpJ_X7S-izdjTWxK=g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: media: Add Allwinner A10 CSI binding
To: Maxime Ripard <maxime.ripard@bootlin.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_081723_129244_A4397C79 
X-CRM114-Status: GOOD (  21.80  )
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
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrzej Hajda <a.hajda@samsung.com>, Chen-Yu Tsai <wens@csie.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Mon, Jan 28, 2019 at 8:52 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The Allwinner A10 CMOS Sensor Interface is a camera capture interface also
> used in later (A10s, A13, A20, R8 and GR8) SoCs.
>
> On some SoCs, like the A10, there's multiple instances of that controller,
> with one instance supporting more channels and having an ISP.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
>
> diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
> new file mode 100644
> index 000000000000..f550fefa074f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-csi.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)

X11 is generally wrong because it is specific to X Consortium. MIT is
what you want.

The core bindings are using 'GPL-2.0 OR BSD-2-Clause'. I don't think
it really matters whether we have a mixture of MIT and BSD, but if you
don't have a reason to deviate, I wouldn't.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/allwinner,sun4i-a10-csi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Allwinner A10 CMOS Sensor Interface (CSI) Device Tree Bindings
> +
> +maintainers:
> +  - Chen-Yu Tsai <wens@csie.org>
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Allwinner A10 CSI0 Controller
> +        items:
> +        - const: allwinner,sun4i-a10-csi0
> +
> +      - description: Allwinner A20 CSI0 Controller
> +        items:
> +        - const: allwinner,sun7i-a20-csi0

You may want to use 'enum' here if you will have more to add later.

> +        - const: allwinner,sun4i-a10-csi0
> +
> +  reg:
> +    description: The base address and size of the memory-mapped region

IMO, we don't need to define what 'reg' is everywhere.

> +    maxItems: 1
> +
> +  interrupts:
> +    description: The interrupt associated to this IP

Same here.

> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4
> +    maxItems: 4

No need for these. We count 'items' and add them automatically. You
only need them if the size is variable.

> +    items:
> +      - description: The CSI interface clock
> +      - description: The CSI module clock
> +      - description: The CSI ISP clock
> +      - description: The CSI DRAM clock
> +
> +  clock-names:
> +    minItems: 4
> +    maxItems: 4

Same here.

> +    items:
> +      - const: bus
> +      - const: mod
> +      - const: isp
> +      - const: ram
> +
> +  resets:
> +    description: The reset line driver this IP
> +    maxItems: 1
> +
> +  pinctrl-0: true

No defined length? I guess we generally allow a variable number of entries.

> +
> +  pinctrl-names:
> +    description:
> +      When present, must have one state named "default" that sets up
> +      pins for ordinary operations.
> +    minItems: 1
> +    maxItems: 1
> +    items:
> +      - const: default

A single entry can be simplified to just 'const: default' under pinctrl-names.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +# The media OF-graph binding hasn't been described yet
> +# additionalProperties: false
> --
> git-series 0.9.1

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
