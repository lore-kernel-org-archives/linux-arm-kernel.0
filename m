Return-Path: <SRS0=txfi=PP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A40DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:03:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1707520838
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 02:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bXJ+lBFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1707520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2AzKfUo+oUWcrIW7XgAaKMbh9uDOeGeYhpmoRFNDFkk=; b=bXJ+lBFcijGfT3
	V+3jbN4cG+x+BJTuSAWJpP78iVUsI0zP6+reXHtUHXPbPvTtlOQXsT6pwGGGjVl/QM2FTimlT22Pt
	4FsvS4H2RhM4Iu4DnVDNpjghQ7UaznnUkteJaDW1d5TSzhjTdfz3R3rYOT8tMjPqYK4QspSmgwksq
	FWhdjo/RcYX/ONo0vDU5KFIXGGVCVHug7EmgvRki4XN2FniBxzVyUoTJ64za5ZkArTHNT4axiW1+L
	0MetMpzmpcYqRt1s8dsBaKurZIHTBtL13+bIzKt7bE61guElNc9b4+0eaDHbH0aGJ53+ZmiijJhBk
	VrXIGKXMMSEIMUZilxTg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggKGR-0006be-W3; Mon, 07 Jan 2019 02:03:40 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggKGJ-0006aF-Fd; Mon, 07 Jan 2019 02:03:36 +0000
X-UUID: b093ebcfea724448bad530fe21aa31b0-20190106
X-UUID: b093ebcfea724448bad530fe21aa31b0-20190106
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <zhiyong.tao@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1653172570; Sun, 06 Jan 2019 18:02:54 -0800
Received: from MTKMBS02N2.mediatek.inc (172.21.101.101) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 6 Jan 2019 18:02:53 -0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs02n2.mediatek.inc
 (172.21.101.101) with Microsoft SMTP Server (TLS) id 15.0.1395.4;
 Mon, 7 Jan 2019 10:02:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 7 Jan 2019 10:02:50 +0800
Message-ID: <1546826570.3267.0.camel@mhfsdcap03>
Subject: Re: [PATCH v5 5/6] dt-bindings: pinctrl: mt8183: add binding document
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: Sean Wang <sean.wang@kernel.org>
Date: Mon, 7 Jan 2019 10:02:50 +0800
In-Reply-To: <CAGp9LzpNTKxgPyPOFQefJ1B_459dFtGUseW2sKHTiESDVLj9jw@mail.gmail.com>
References: <1545984581-25843-1-git-send-email-erin.lo@mediatek.com>
 <1545984581-25843-6-git-send-email-erin.lo@mediatek.com>
 <20181228220405.GA8739@bogus> <1546585723.21915.7.camel@mhfsdcap03>
 <CAGp9LzoAyZqC53eo4JKcouu=pNgsGm9FFm1GaxbH1Jc1OD8Bvw@mail.gmail.com>
 <1546594814.21915.16.camel@mhfsdcap03>
 <CAGp9LzpNTKxgPyPOFQefJ1B_459dFtGUseW2sKHTiESDVLj9jw@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E210B8FF21D57CAC3248F7F1E8E314A21461913E922D23FBA047133A6E91F1A52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190106_180331_532173_7D856423 
X-CRM114-Status: GOOD (  33.10  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Jason Cooper <jason@lakedaemon.net>,
 srv_heupstream <srv_heupstream@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Marc
 Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erin Lo =?UTF-8?Q?=28=E7=BE=85=E9=9B=85=E9=BD=A1=29?= <erin.lo@mediatek.com>,
 Stephen Boyd <sboyd@codeaurora.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?=
 <Yingjoe.Chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Mars Cheng =?UTF-8?Q?=28=E9=84=AD=E6=A3=AE=E5=8F=8B=29?=
 <Mars.Cheng@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?=
 <eddie.huang@mediatek.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, 2019-01-04 at 01:55 -0800, Sean Wang wrote:
> On Fri, Jan 4, 2019 at 1:40 AM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> >
> > On Fri, 2019-01-04 at 01:14 -0800, Sean Wang wrote:
> > > On Thu, Jan 3, 2019 at 11:09 PM Zhiyong Tao <zhiyong.tao@mediatek.com> wrote:
> > > >
> > > > On Sat, 2018-12-29 at 06:04 +0800, Rob Herring wrote:
> > > > > On Fri, Dec 28, 2018 at 04:09:40PM +0800, Erin Lo wrote:
> > > > > > From: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > >
> > > > > > The commit adds mt8183 compatible node in binding document.
> > > > > >
> > > > > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/pinctrl/pinctrl-mt8183.txt | 110 +++++++++++++++++++++
> > > > > >  1 file changed, 110 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > > > > new file mode 100644
> > > > > > index 0000000..7b5285e
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8183.txt
> > > > > > @@ -0,0 +1,110 @@
> > > > > > +* Mediatek MT8183 Pin Controller
> > > > > > +
> > > > > > +The Mediatek's Pin controller is used to control SoC pins.
> > > > > > +
> > > > > > +Required properties:
> > > > > > +- compatible: value should be one of the following.
> > > > > > +   "mediatek,mt8183-pinctrl", compatible with mt8183 pinctrl.
> > > > > > +- gpio-controller : Marks the device node as a gpio controller.
> > > > > > +- #gpio-cells: number of cells in GPIO specifier. Since the generic GPIO
> > > > > > +  binding is used, the amount of cells must be specified as 2. See the below
> > > > > > +  mentioned gpio binding representation for description of particular cells.
> > > > > > +- gpio-ranges : gpio valid number range.
> > > > > > +
> > > > > > +   Eg: <&pio 6 0>
> > > > > > +   <[phandle of the gpio controller node]
> > > > > > +   [line number within the gpio controller]
> > > > > > +   [flags]>
> > > > > > +
> > > > > > +   Values for gpio specifier:
> > > > > > +   - Line number: is a value between 0 to 202.
> > > > > > +   - Flags:  bit field of flags, as defined in <dt-bindings/gpio/gpio.h>.
> > > > > > +            Only the following flags are supported:
> > > > > > +            0 - GPIO_ACTIVE_HIGH
> > > > > > +            1 - GPIO_ACTIVE_LOW
> > > > > > +
> > > > > > +Optional properties:
> > > > > > +- reg: physicall address base for gpio base registers.
> > > > >
> > > > > s/physicall/physical/
> > > > >
> > > > > reg should never be optional.
> > > > >
> > > > > Need to say how many reg entries.
> > > >
> > > > ==> Thanks for your suggestion. We will change 'reg' to Required
> > > > properties and add the reg entries in next version.
> > > > >
> > > > > > +- reg-names: gpio base registers name.
> > > > >
> > > > > Need to say what are the names. However, I don't find the names in the
> > > > > example all that useful, so I'd just drop it.
> > > >
> > > > ==> we will add the reg-names in next version.
> > > > They are used in the sample code, such as:
> > > > > +             reg-names = "iocfg0", "iocfg1", "iocfg2",
> > > > > > +                       "iocfg3", "iocfg4", "iocfg5",
> > > > > > +                       "iocfg6", "iocfg7", "iocfg8";
> > > >
> > > > >
> > > > > > +- interrupt-controller: Marks the device node as an interrupt controller
> > > > > > +- #interrupt-cells: Should be two.
> > > > > > +- interrupts : The interrupt outputs from the controller.
> > > > > > +
> > > > > > +Please refer to pinctrl-bindings.txt in this directory for details of the
> > > > > > +common pinctrl bindings used by client devices.
> > > > > > +
> > > > > > +Subnode format
> > > > > > +A pinctrl node should contain at least one subnodes representing the
> > > > > > +pinctrl groups available on the machine. Each subnode will list the
> > > > > > +pins it needs, and how they should be configured, with regard to muxer
> > > > > > +configuration, pullups, drive strength, input enable/disable and input schmitt.
> > > > > > +
> > > > > > +    node {
> > > > > > +   pinmux = <PIN_NUMBER_PINMUX>;
> > > > > > +   GENERIC_PINCONFIG;
> > > > > > +    };
> > > > > > +
> > > > > > +Required properties:
> > > > > > +- pinmux: integer array, represents gpio pin number and mux setting.
> > > > > > +    Supported pin number and mux varies for different SoCs, and are defined
> > > > > > +    as macros in boot/dts/<soc>-pinfunc.h directly.
> > > > > > +
> > > > > > +Optional properties:
> > > > > > +- GENERIC_PINCONFIG: is the generic pinconfig options to use, bias-disable,
> > > > > > +    bias-pull-down, bias-pull-up, input-enable, input-disable, output-low, output-high,
> > > > > > +    input-schmitt-enable, input-schmitt-disable and drive-strength are valid.
> > > > > > +
> > > > > > +    Some special pins have extra pull up strength, there are R0 and R1 pull-up
> > > > > > +    resistors available, but for user, it's only need to set R1R0 as 00, 01, 10 or 11.
> > > > > > +    So when config mediatek,pull-up-adv or mediatek,pull-down-adv,
> > > > > > +    it support arguments for those special pins.
> > > > > > +
> > > > > > +    When config drive-strength, it can support some arguments, such as
> > > > > > +    MTK_DRIVE_4mA, MTK_DRIVE_6mA, etc. See dt-bindings/pinctrl/mt65xx.h.
> > > > > > +
> > >
> > > One point we can fix more is the drive-strength already is supported
> > > as the generic one, not need to depend on a dedicated header file.
> >
> > ==> We think that we use MTK_DRIVE_4mA to set as driving in dts. it it
> > more clear in v2 common driver for single pin -> single group mode.
> > How about the idea?
> >
> 
> Sure, thank for post your idea and it sounds not bad to keep the
> convention for the single pin -> single group mode binding.

Thanks for your confirm. We will keep it in next version.
> 
> > Thanks.
> > >
> > > > > > +Examples:
> > > > > > +
> > > > > > +#include "mt8183-pinfunc.h"
> > > > > > +
> > > > > > +...
> > > > > > +{
> > > > > > +   pio: pinctrl@10005000 {
> > > > > > +           compatible = "mediatek,mt8183-pinctrl";
> > > > > > +           reg = <0 0x10005000 0 0x1000>,
> > > > > > +                 <0 0x11F20000 0 0x1000>,
> > > > > > +                 <0 0x11E80000 0 0x1000>,
> > > > > > +                 <0 0x11E70000 0 0x1000>,
> > > > > > +                 <0 0x11E90000 0 0x1000>,
> > > > > > +                 <0 0x11D30000 0 0x1000>,
> > > > > > +                 <0 0x11D20000 0 0x1000>,
> > > > > > +                 <0 0x11C50000 0 0x1000>,
> > > > > > +                 <0 0x11F30000 0 0x1000>;
> > > > > > +           reg-names = "iocfg0", "iocfg1", "iocfg2",
> > > > > > +                       "iocfg3", "iocfg4", "iocfg5",
> > > > > > +                       "iocfg6", "iocfg7", "iocfg8";
> > > > > > +           gpio-controller;
> > > > > > +           #gpio-cells = <2>;
> > > > > > +           gpio-ranges = <&pio 0 0 192>;
> > > > > > +           interrupt-controller;
> > > > > > +           interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> > > > > > +           interrupt-parent = <&gic>;
> > > > > > +           #interrupt-cells = <2>;
> > > > > > +
> > > > > > +           i2c0_pins_a: i2c0@0 {
> > > > >
> > > > > unit-address without reg property is not valid.
> > > >
> > > > ==> we will change "i2c0_pins_a: i2c0@0" to "i2c0_pins_a: i2c0" in the
> > > > next version.
> > > > >
> > > > > > +                   pins1 {
> > > > > > +                           pinmux = <PINMUX_GPIO48__FUNC_SCL5>,
> > > > > > +                                    <PINMUX_GPIO49__FUNC_SDA5>;
> > > > > > +                           mediatek,pull-up-adv = <11>;
> > > > > > +                   };
> > > > > > +           };
> > > > > > +
> > > > > > +           i2c1_pins_a: i2c1@0 {
> > > > > > +                   pins {
> > > > > > +                           pinmux = <PINMUX_GPIO50__FUNC_SCL3>,
> > > > > > +                                    <PINMUX_GPIO51__FUNC_SDA3>;
> > > > > > +                           mediatek,pull-down-adv = <10>;
> > > > > > +                   };
> > > > > > +           };
> > > > > > +           ...
> > > > > > +   };
> > > > > > +};
> > > > > > --
> > > > > > 1.9.1
> > > > > >
> > > >
> > > >
> > > >
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
> >



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
