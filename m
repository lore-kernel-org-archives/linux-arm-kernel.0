Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284F6C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAEE2173C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IEVPTK60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAEE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2MzCfqzRqY0FRCyiKoepL0oe62ciHd47fPxSXdxooAc=; b=IEVPTK60Ggz1Rl
	dVn2nmUtIEFnRUYLYuP+i3S5gMDfgSqc+tN95HrZVbFgZZJSwVTMTB0kDeFkaOV655giYH3H6O9Zg
	idsiAoprN9tUq0ElfhIYnY6GJPE2fbhf9lAqP24PnL1kJjgUgR+JnLgnTd+MQW0FED7YLlClP0SDg
	y+EV7gd2eltrhSWoJIVkFahUzFcWhPf5MoNtA9jy/ZYZ5uDy7rpuqGuG6izwGLarPpiXY0ST+9EXW
	pRpyPC6dkvhNsCb/PXph0HAQVEQApsxnY52heoMN+uqy5JD1xYj8yaJEX2NFCeQuukG6wfNy5khXA
	dKUaJC+TvDouUKxV2a2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvlqI-0002c2-8M; Mon, 18 Feb 2019 16:32:30 +0000
Received: from mail-ot1-f67.google.com ([209.85.210.67])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvlq3-0002Ph-Km; Mon, 18 Feb 2019 16:32:19 +0000
Received: by mail-ot1-f67.google.com with SMTP id c18so7658444otl.13;
 Mon, 18 Feb 2019 08:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tXthgMlesEt0O00xMha7QT2gW6v4lM9kmkhPo+CRVnY=;
 b=OHcvFuIhVzs1Z/NuJX32b/fS8atpQfEzgkLbi87kbi+pHWskIX9ejkYbHoeiAPR4p6
 fNSSKrNbIjLTgvn9omHcF0bClyO+pqF4H2eMDkbxKUyC46YcfLR+1c9CcODRg26NRrdf
 CYeyErgUc1JLpNdvGqbkVNzvwTiEmgS3l/JmGksxx+rgjB6BCdEA2tOsJBq4cOxcqqPW
 Tt62oeumV6fPQ+Czw56NleWsCZYBgzDZgKgKIBmR/0uT5FwZoq7x6hHtOaVCqeFNxVy5
 gQjL1mDxmjdDuhlM9S+Bh3v/+LsHYFhGzwo1OiGqqi5pUff/eo3PWWLp0X9SogUnh2G7
 PYBA==
X-Gm-Message-State: AHQUAuaOl55gjYQzOiiPFA01Hxek9Efvb6o5uVkQEQ+qx+SD1+oOeJJP
 5bTLhJ0fIVUJei79CqETiQ==
X-Google-Smtp-Source: AHgI3IbCwSaEIRYaYpGX1dex6jVwJItZQ3jSw44SD43q80c47p0Em7WGy87MNjIomI7AaHRyBhPo8g==
X-Received: by 2002:aca:e690:: with SMTP id
 d138mr15166994oih.109.1550507532779; 
 Mon, 18 Feb 2019 08:32:12 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i16sm2659029oto.77.2019.02.18.08.32.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 18 Feb 2019 08:32:12 -0800 (PST)
Date: Mon, 18 Feb 2019 10:32:11 -0600
From: Rob Herring <robh@kernel.org>
To: Erin Lo <erin.lo@mediatek.com>
Subject: Re: [PATCH v7 3/6] dt-bindings: pinctrl: mt8183: add binding document
Message-ID: <20190218163211.GB2714@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1550210558-30516-4-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_083215_685635_AF7D2DE9 
X-CRM114-Status: GOOD (  25.73  )
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
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>,
 linux-kernel@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
 mars.cheng@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
 eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Feb 15, 2019 at 02:02:35PM +0800, Erin Lo wrote:
> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> 
> The commit adds mt8183 compatible node in binding document.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
>  1 file changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> new file mode 100644
> index 0000000..364e673
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> @@ -0,0 +1,115 @@
> +* Mediatek MT8183 Pin Controller
> +
> +The Mediatek's Pin controller is used to control SoC pins.
> +
> +Required properties:
> +- compatible: value should be one of the following.
> +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> +- gpio-controller : Marks the device node as a gpio controller.
> +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> +  binding is used, the amount of cells must be specified as 2. See the below
> +  mentioned gpio binding representation for description of particular cells.
> +- gpio-ranges : gpio valid number range.
> +- reg: physicall address base for gpio base registers. There are nine
> +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> +  0x11F30000.

You don't need to list out each address, just what each address is. (Or 
just '9 GPIO base addresses'.)

> +
> +	Eg: <&pio 6 0>

How is this an example of reg? Seems something is missing.

> +	<[phandle of the gpio controller node]
> +	[line number within the gpio controller]
> +	[flags]>
> +
> +	Values for gpio specifier:
> +	- Line number: is a value between 0 to 202.
> +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> +            Only the following flags are supported:
> +            0 - GPIO_ACTIVE_HIGH
> +            1 - GPIO_ACTIVE_LOW
> +
> +Optional properties:
> +- reg-names: gpio base register names. There are nine gpio base register
> +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> +- interrupt-controller: Marks the device node as an interrupt controller
> +- #interrupt-cells: Should be two.
> +- interrupts : The interrupt outputs from the controller.

outputs? More than 1? If so, need to say what they are and the order.

> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices.
> +
> +Subnode format
> +A pinctrl node should contain at least one subnodes representing the
> +pinctrl groups available on the machine. Each subnode will list the
> +pins it needs, and how they should be configured, with regard to muxer
> +configuration, pullups, drive strength, input enable/disable and input schmitt.
> +
> +    node {
> +	pinmux = <PIN_NUMBER_PINMUX>;
> +	GENERIC_PINCONFIG;
> +    };
> +
> +Required properties:
> +- pinmux: integer array, represents gpio pin number and mux setting.
> +    Supported pin number and mux varies for different SoCs, and are defined
> +    as macros in boot/dts/<soc>-pinfunc.h directly.
> +
> +Optional properties:
> +- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
> +    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
> +    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
> +
> +    Some special pins have extra pull up strength, there are R0 and R1 pull-up
> +    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
> +    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
> +    it support arguments for those special pins.
> +
> +    When config drive-strength, it can support some arguments, such as
> +    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
> +
> +Examples:
> +
> +#include "mt8183-pinfunc.h"
> +
> +...
> +{
> +	pio: pinctrl@10005000 {
> +		compatible = "mediatek,mt8183-pinctrl";
> +		reg = <0 0x10005000 0 0x1000>,
> +		      <0 0x11F20000 0 0x1000>,
> +		      <0 0x11E80000 0 0x1000>,
> +		      <0 0x11E70000 0 0x1000>,
> +		      <0 0x11E90000 0 0x1000>,
> +		      <0 0x11D30000 0 0x1000>,
> +		      <0 0x11D20000 0 0x1000>,
> +		      <0 0x11C50000 0 0x1000>,
> +		      <0 0x11F30000 0 0x1000>;
> +		reg-names = "iocfg0", "iocfg1", "iocfg2",
> +			    "iocfg3", "iocfg4", "iocfg5",
> +			    "iocfg6", "iocfg7", "iocfg8";
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-ranges = <&pio 0 0 192>;
> +		interrupt-controller;
> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-parent = <&gic>;
> +		#interrupt-cells = <2>;
> +
> +		i2c0_pins_a: i2c0 {
> +			pins1 {
> +				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
> +					 <PINMUX_GPIO49__FUNC_SDA5>;
> +				mediatek,pull-up-adv = <11>;
> +			};
> +		};
> +
> +		i2c1_pins_a: i2c1 {
> +			pins {
> +				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
> +					 <PINMUX_GPIO51__FUNC_SDA3>;
> +				mediatek,pull-down-adv = <10>;
> +			};
> +		};
> +		...
> +	};
> +};
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
