Return-Path: <SRS0=iy7m=RA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7DC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:31:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6089D20643
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 22:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I18cqUPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6089D20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZqQWxnXGDlD/lGTSatGv3AP78rfiOSu0jqc+mgd6dkQ=; b=I18cqUPg06EP8y
	wmoy7qB0fAaaFVWrmFoLnpAH4I7jovASvWW9CuP1BfrT0YKo8niyVOIhbJDOH+v80DUJpJiCTMJ25
	4+dObImcrg/83t+Be4eWbJd0lO1fVqtQxZbg1utSCLPxouhbbRUEsooZ4WJdRqKPOns7duNgS6eVb
	KzwXDqwoV3Ewfrh9HJ5xwFyrqDbiaN17mI1C9jNaLNwjDO7Kv6zDm1VnmUps5gafQJ1e/RjdJ/xJe
	xIqyeKYBrtEv5QuSfftgPnt3gfNxi6888Lz/ajg8+KhB2yCcQlqLq6PfOecHSMttEKYd9hQowPI1w
	lfacOQmWrJBGIEZj5WEA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyOmY-0008Iw-6D; Mon, 25 Feb 2019 22:31:30 +0000
Received: from mail-ot1-f66.google.com ([209.85.210.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyOmU-0008IR-PF
 for linux-arm-kernel@lists.infradead.org; Mon, 25 Feb 2019 22:31:28 +0000
Received: by mail-ot1-f66.google.com with SMTP id n71so9354041ota.10
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 25 Feb 2019 14:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XOHZxHaSuU84IfXgL237fK0gTraF0basqETKE9bRG3s=;
 b=cgXTXaSeZ/dg3fiJqzU6y0dU1W7cB+EKobmJkZQ+uBHReyZ/LN18Om5Lqxb9kbH8a6
 NHWSyvSh9fXoMytTBrolRshzGiRjfkPysZxAiO7F1sKJBebo7LGP6kDgJlch+c+KeO1K
 arGUdmUyGfNCtpTmAjyRcP4FihQtZZL5Wq5ZlDOUKsjEzVVVfzdFun/UgH1vQXHBAK3J
 44umIEtNdiAhZLEvlBlfb1OQzIQvOhY6SMoZqTRHGmjnkQT1SjFDaM4m2NcBOTulFm+0
 yLwj9Q5/VapjKu7kGCwtPRlhl50Dy6hQZY0afobWiHdV7otrjSqpQnz306lX6jZnVN8s
 seSA==
X-Gm-Message-State: AHQUAuYn0vy/BdLecxdiuoC9XqJM1ZkvLIHZ1ecWMKWUUDQQPPcoTSo7
 9Ag2XCAshk4rm3s1Zg0dzegkttE=
X-Google-Smtp-Source: AHgI3Ialot/tP8oTROHUHmD+S4ULYEgPlUG4/gK9zLM+SDmN8Sh9VF05zLXS2g5gUYwm68ImsIsiKg==
X-Received: by 2002:a05:6830:1c1:: with SMTP id
 r1mr2432961ota.229.1551133885524; 
 Mon, 25 Feb 2019 14:31:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id e138sm5437756oih.27.2019.02.25.14.31.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 14:31:24 -0800 (PST)
Date: Mon, 25 Feb 2019 16:31:24 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/4] drm/mcde: Add device tree bindings
Message-ID: <20190225223124.GA29057@bogus>
References: <20190207083647.20615-1-linus.walleij@linaro.org>
 <20190207083647.20615-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190207083647.20615-3-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_143126_826545_2242CFD1 
X-CRM114-Status: GOOD (  24.07  )
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
Cc: David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, Feb 07, 2019 at 09:36:45AM +0100, Linus Walleij wrote:
> This adds the device tree bindings for the ST-Ericsson
> Multi Channel Display Engine MCDE as found in the U8500
> SoCs.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/display/ste,mcde.txt  | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ste,mcde.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/ste,mcde.txt b/Documentation/devicetree/bindings/display/ste,mcde.txt
> new file mode 100644
> index 000000000000..fc58aa5effb5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ste,mcde.txt
> @@ -0,0 +1,110 @@
> +ST-Ericsson Multi Channel Display Engine MCDE
> +
> +The ST-Ericsson MCDE is a display controller with support for compositing
> +and displaying several channels memory resident graphics data on DSI or
> +LCD displays or bridges. It is used in the ST-Ericsson U8500 platform.
> +
> +Required properties:
> +
> +- compatible: must be:
> +  "ste,mcde"

Only one version? This too is old enough, I'm not too worried about how 
specific the compatibles are here.

> +- reg: register base for the main MCDE control registers, should be
> +  0x1000 in size
> +- interrupts: the interrupt line for the MCDE
> +- epod-supply: a phandle to the EPOD regulator
> +- vana-supply: a phandle to the analog voltage regulator
> +- clocks: an array of the MCDE clocks in this strict order:
> +  MCDECLK (main MCDE clock), LCDCLK (LCD clock), PLLDSI
> +  (HDMI clock), DSI0ESCLK (DSI0 energy save clock),
> +  DSI1ESCLK (DSI1 energy save clock), DSI2ESCLK (DSI2 energy
> +  save clock)
> +- clock-names: must be the following array:
> +  "mcde", "lcd", "hdmi", "dsi0", "dsi1", "dsi0es", "dsi1es", "dsi2es"

dsi2 clock?

Should the dsi clocks be in the child nodes?

> +  to match the required clock inputs above.
> +- #address-cells: should be <1> (for the DSI hosts that will be children)
> +- #size-cells: should be <1> (for the DSI hosts that will be children)
> +- ranges: this should always be stated
> +
> +Required subnodes:
> +
> +The devicetree must specify subnodes for the DSI host adapters.
> +These must have the following characteristics:
> +
> +- compatible: must be:
> +  "ste,mcde-dsi"
> +- reg: must specify the register range for the DSI host
> +- vana-supply: phandle to the VANA voltage regulator
> +- #address-cells: should be <1>
> +- #size-cells: should be <0>
> +
> +Display panels and bridges will appear as children on the DSI hosts, and
> +the displays are connected to the DSI hosts using the common binding
> +for video transmitter interfaces; see
> +Documentation/devicetree/bindings/media/video-interfaces.txt
> +
> +If a DSI host is unused (not connected) it will have no children or ports
> +defined.
> +
> +Example:
> +
> +mcde@a0350000 {
> +	compatible = "ste,mcde";
> +	reg = <0xa0350000 0x1000>;
> +	interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> +	epod-supply = <&db8500_b2r2_mcde_reg>;
> +	vana-supply = <&ab8500_ldo_ana_reg>;
> +	clocks = <&prcmu_clk PRCMU_MCDECLK>, /* Main MCDE clock */
> +		 <&prcmu_clk PRCMU_LCDCLK>, /* LCD clock */
> +		 <&prcmu_clk PRCMU_PLLDSI>, /* HDMI clock */
> +		 <&prcmu_clk PRCMU_DSI0CLK>, /* DSI 0 */
> +		 <&prcmu_clk PRCMU_DSI1CLK>, /* DSI 1 */
> +		 <&prcmu_clk PRCMU_DSI0ESCCLK>, /* TVout clock 0 */
> +		 <&prcmu_clk PRCMU_DSI1ESCCLK>, /* TVout clock 1 */
> +		 <&prcmu_clk PRCMU_DSI2ESCCLK>; /* TVout clock 2 */
> +	clock-names = "mcde", "lcd", "hdmi", "dsi0", "dsi1",
> +		    "dsi0es", "dsi1es", "dsi2es";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;

A non-empty ranges is preferred, then you can just do offsets below.

> +
> +	dsi0: dsi@a0351000 {
> +		compatible = "ste,mcde-dsi";
> +		reg = <0xa0351000 0x1000>;
> +		vana-supply = <&ab8500_ldo_ana_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		port {
> +			dsi0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +
> +		panel: display {

'panel' would be the somewhat more standard node name.

> +			compatible = "samsung,s6d16d0";
> +			reg = <0>;
> +			vdd1-supply = <&ab8500_ldo_aux1_reg>;
> +			reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
> +
> +			port {
> +				panel_in: endpoint {
> +					remote-endpoint = <&dsi0_out>;

You don't really need the graph here as it is already a child. Generally 
it is either or. The driver can support both ways though.

> +				};
> +			};
> +		};
> +
> +	};
> +	dsi1: dsi@a0352000 {
> +		compatible = "ste,mcde-dsi";
> +		reg = <0xa0352000 0x1000>;
> +		vana-supply = <&ab8500_ldo_ana_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +	dsi2: dsi@a0353000 {
> +		compatible = "ste,mcde-dsi";
> +		reg = <0xa0353000 0x1000>;
> +		vana-supply = <&ab8500_ldo_ana_reg>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> -- 
> 2.20.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
