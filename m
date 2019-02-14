Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDBAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:30:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA0D2075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qxVYkBjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA0D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6LAeM56l5k28om3WGAOej8C2WTJcqwB8tp0BNCNOckc=; b=qxVYkBjyAKdMcx
	ZtAiIP04vp97rwPnbXdwSuaWk66MatMbJfKz6f+zr+5mlUnno2pJxaTez5R/rHffN2SsT3Xqd6VMC
	x92tHNgDfWjWiYeHwFyYl744CDuR8Rrk4PBkFoZDXER2Okt5kZUkoiDJ0djYlTnpcujqO0GjQfwk/
	8unobDgQz9LDhdA0R+ZANmGUsWCRpOGzzAf5WkGDnhJsYClQVKPkiJ1sRcQ/LPx9/sJiZ9k/C+si6
	uMQEnB2VGdvRUjJTSP7YUSYEfFwY87nrJw2mR63hTkBM9xzammAG9a8Jc0VughV8zxu3s4V9MLBpq
	rC8fTy+Yexc0gcEXRHwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gu7it-0004Cc-Ad; Thu, 14 Feb 2019 03:30:03 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gu7io-00040E-AX; Thu, 14 Feb 2019 03:30:00 +0000
X-UUID: fd28fc8d32534052b0bde2189ecfb3fe-20190213
X-UUID: fd28fc8d32534052b0bde2189ecfb3fe-20190213
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <erin.lo@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1632084215; Wed, 13 Feb 2019 19:29:44 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 19:29:43 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 11:29:41 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 11:29:41 +0800
Message-ID: <1550114981.4262.3.camel@mtksdaap41>
Subject: Re: [PATCH v6 5/6] dt-bindings: pinctrl: mt8183: add binding document
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Date: Thu, 14 Feb 2019 11:29:41 +0800
In-Reply-To: <d76bb2e8-5285-15ce-b850-6cf3065e0777@gmail.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-6-git-send-email-erin.lo@mediatek.com>
 <d76bb2e8-5285-15ce-b850-6cf3065e0777@gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_192958_374951_4EE5A95E 
X-CRM114-Status: GOOD (  27.10  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, mars.cheng@mediatek.com,
 Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
 yingjoe.chen@mediatek.com, Thomas Gleixner <tglx@linutronix.de>,
 eddie.huang@mediatek.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Thu, 2019-02-07 at 16:28 +0100, Matthias Brugger wrote:
> 
> On 24/01/2019 09:07, Erin Lo wrote:
> > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > 
> > The commit adds mt8183 compatible node in binding document.
> > 
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> 
> I'm missing Linus Walleij on the recipient list.
> Pleas make sure to add all persons from the get_maintainers script.
> IMHO it's a bit unfortunate that we got the driver merged, but no binding
> description. Please try to send driver + binding documentation together, that
> makes things easier to discuss.
> 
> Thanks,
> Matthias
> 

OK! I will add Linus Walleij on the recipient list.
It's right..the binding should send together with driver code.
We will pay more attention of this next time.
Thank you for your reminder.

Best Regards,
Erin

> >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 115 +++++++++++++++++++++
> >  1 file changed, 115 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > new file mode 100644
> > index 0000000..364e673
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > @@ -0,0 +1,115 @@
> > +* Mediatek MT8183 Pin Controller
> > +
> > +The Mediatek's Pin controller is used to control SoC pins.
> > +
> > +Required properties:
> > +- compatible: value should be one of the following.
> > +	"mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > +- gpio-controller : Marks the device node as a gpio controller.
> > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > +  binding is used, the amount of cells must be specified as 2. See the below
> > +  mentioned gpio binding representation for description of particular cells.
> > +- gpio-ranges : gpio valid number range.
> > +- reg: physicall address base for gpio base registers. There are nine
> > +  physicall address base in mt8183. They are 0x10005000, 0x11F20000,
> > +  0x11E80000, 0x11E70000, 0x11E90000, 0x11D30000, 0x11D20000, 0x11C50000,
> > +  0x11F30000.
> > +
> > +	Eg: <&pio 6 0>
> > +	<[phandle of the gpio controller node]
> > +	[line number within the gpio controller]
> > +	[flags]>
> > +
> > +	Values for gpio specifier:
> > +	- Line number: is a value between 0 to 202.
> > +	- Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > +            Only the following flags are supported:
> > +            0 - GPIO_ACTIVE_HIGH
> > +            1 - GPIO_ACTIVE_LOW
> > +
> > +Optional properties:
> > +- reg-names: gpio base register names. There are nine gpio base register
> > +  names in mt8183. They are "iocfg0", "iocfg1", "iocfg2", "iocfg3", "iocfg4",
> > +  "iocfg5", "iocfg6", "iocfg7", "iocfg8".
> > +- interrupt-controller: Marks the device node as an interrupt controller
> > +- #interrupt-cells: Should be two.
> > +- interrupts : The interrupt outputs from the controller.
> > +
> > +Please refer to pinctrl-bindings.txt in this directory for details of the
> > +common pinctrl bindings used by client devices.
> > +
> > +Subnode format
> > +A pinctrl node should contain at least one subnodes representing the
> > +pinctrl groups available on the machine. Each subnode will list the
> > +pins it needs, and how they should be configured, with regard to muxer
> > +configuration, pullups, drive strength, input enable/disable and input schmitt.
> > +
> > +    node {
> > +	pinmux = <PIN_NUMBER_PINMUX>;
> > +	GENERIC_PINCONFIG;
> > +    };
> > +
> > +Required properties:
> > +- pinmux: integer array, represents gpio pin number and mux setting.
> > +    Supported pin number and mux varies for different SoCs, and are defined
> > +    as macros in boot/dts/<soc>-pinfunc.h directly.
> > +
> > +Optional properties:
> > +- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
> > +    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
> > +    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
> > +
> > +    Some special pins have extra pull up strength, there are R0 and R1 pull-up
> > +    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
> > +    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
> > +    it support arguments for those special pins.
> > +
> > +    When config drive-strength, it can support some arguments, such as
> > +    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
> > +
> > +Examples:
> > +
> > +#include "mt8183-pinfunc.h"
> > +
> > +...
> > +{
> > +	pio: pinctrl@10005000 {
> > +		compatible = "mediatek,mt8183-pinctrl";
> > +		reg = <0 0x10005000 0 0x1000>,
> > +		      <0 0x11F20000 0 0x1000>,
> > +		      <0 0x11E80000 0 0x1000>,
> > +		      <0 0x11E70000 0 0x1000>,
> > +		      <0 0x11E90000 0 0x1000>,
> > +		      <0 0x11D30000 0 0x1000>,
> > +		      <0 0x11D20000 0 0x1000>,
> > +		      <0 0x11C50000 0 0x1000>,
> > +		      <0 0x11F30000 0 0x1000>;
> > +		reg-names = "iocfg0", "iocfg1", "iocfg2",
> > +			    "iocfg3", "iocfg4", "iocfg5",
> > +			    "iocfg6", "iocfg7", "iocfg8";
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +		gpio-ranges = <&pio 0 0 192>;
> > +		interrupt-controller;
> > +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupt-parent = <&gic>;
> > +		#interrupt-cells = <2>;
> > +
> > +		i2c0_pins_a: i2c0 {
> > +			pins1 {
> > +				pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
> > +					 <PINMUX_GPIO49__FUNC_SDA5>;
> > +				mediatek,pull-up-adv = <11>;
> > +			};
> > +		};
> > +
> > +		i2c1_pins_a: i2c1 {
> > +			pins {
> > +				pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
> > +					 <PINMUX_GPIO51__FUNC_SDA3>;
> > +				mediatek,pull-down-adv = <10>;
> > +			};
> > +		};
> > +		...
> > +	};
> > +};
> > 



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
