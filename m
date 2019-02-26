Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C7C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:35:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576D320C01
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Af+ukmFl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p6cnLN/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576D320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GpINbXdQ3KW1PeU1hTPnqLkmxdjfMF8KtHFMCeyambc=; b=Af+ukmFl9WJOmr
	hvrKo7qq4anpB597/tBc9N2A13mkx/6MebNRQUwysZrH7SynRtgveqbKUohH+yWbuWriW+8kJSv8B
	oMXTfauC/W3uu8ddY/Jbs9lyMb+7XjWFuoqaavEbLHvHRq/fL5IeGvUl95PZJfv5pYxHJ0vEa1TTQ
	kVOkPPQsWPBsCyP7jxGLGH3I1LFLmQPadFM/7C3xgr/n+RaGyI4C7l5PBVqe8r2qBE9KnbHiWqJ5R
	fTl/ptOGOpmkVmc7qZxDvGYSRhPadwpC87OQFw0dHpvxBQZ4d4c5gSyW0/uUpP0QqjB37lf9tAPkX
	YoRgiWzuiT23u+T/2UdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gydpU-0007Ze-Jb; Tue, 26 Feb 2019 14:35:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydpS-0007ZY-EF
 for linux-arm-kernel@bombadil.infradead.org; Tue, 26 Feb 2019 14:35:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6P9ZgwMWx1A8g4tiZNvrCOkeQvGFViJZzJmfBxznhDA=; b=p6cnLN/PgrIc53IXjLPIJYl9pw
 I/UcCOq7vlGuxczRdX31L/vhXgzwtbhvGL2Jv4WVo1cHV718a2Htw9FnFWlLd0w+HMEchgwr83oCl
 /rCovuwqlaWN7NxzgJa3LdtmM1XniSB6DFTD4fcj0nNzx4vBjNGOlmwxu/f/z6W4K/9hFW+VqVS2n
 lRrbQdpMeTdhtbITEOxR9ryE9Ae2VJCoFnH8wK79M6TxPNzzMYHr4kbM176WqoQ/I91ywaZP54bvI
 3E8cyrMt1gmo4tlGVo1rlD2Qln/uh+4FyGmiSTZNMY2HBL5z2dA+j4jv0Yk844CLJusVVDXiFGjgx
 pSycF4rg==;
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gydpK-0003r9-8I
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 14:35:28 +0000
X-Originating-IP: 90.88.147.150
Received: from aptenodytes (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr
 [90.88.147.150])
 (Authenticated sender: paul.kocialkowski@bootlin.com)
 by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id CA608E0006;
 Tue, 26 Feb 2019 14:34:39 +0000 (UTC)
Message-ID: <8d93f76de896a1a6e516adbf5cfeff8b68b6181d.camel@bootlin.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: panel: Add YAML schemas for the
 Ronbo RB070D30 panel
From: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Sean Paul <seanpaul@chromium.org>
Date: Tue, 26 Feb 2019 15:34:39 +0100
In-Reply-To: <c05b961302ec4a2af32ea6c215ec0749b1a9cff7.1550650810.git-series.maxime.ripard@bootlin.com>
References: <cover.5ac8e6ed5381ceb14a2e5d64671228f665a08d43.1550650810.git-series.maxime.ripard@bootlin.com>
 <c05b961302ec4a2af32ea6c215ec0749b1a9cff7.1550650810.git-series.maxime.ripard@bootlin.com>
Organization: Bootlin
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190226_143522_445244_474557DD 
X-CRM114-Status: GOOD (  14.75  )
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
Cc: linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
 dri-devel@lists.freedesktop.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bbrezillon@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Hi,

On Wed, 2019-02-20 at 09:21 +0100, Maxime Ripard wrote:
> The Ronbo RB070D30 panel is a 1024x600 MIPI-DSI panel.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> ---
>  Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> new file mode 100644
> index 000000000000..a0e6fa1559cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ronbo,rb070d30.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ronbo RB070D30 DSI Display Panel
> +
> +maintainers:
> +  - Maxime Ripard <maxime.ripard@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: ronbo,rb070d30
> +
> +  reg:
> +    description: MIPI-DSI virtual channel
> +
> +  power-gpios:
> +    description: GPIO used for the power pin
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO used for the reset pin
> +    maxItems: 1
> +
> +  shlr-gpios:
> +    description: GPIO used for the shlr pin (horizontal flip)
> +    maxItems: 1
> +
> +  updn-gpios:
> +    description: GPIO used for the updn pin (vertical flip)
> +    maxItems: 1
> +
> +  vcc-lcd-supply:
> +    description: Power regulator
> +
> +  backlight:
> +    description: Backlight used by the panel
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +required:
> +  - compatible
> +  - power-gpios
> +  - reg
> +  - reset-gpios
> +  - shlr-gpios
> +  - updn-gpios
> +  - vcc-lcd-supply
> +
> +additionalProperties: false
> +  
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
