From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 19 Mar 2018 09:28:23 +0800
Subject: [PATCH v4 0/9] Initial Allwinner H6 support
In-Reply-To: <20180318201744.dw6hnm2vdybaunev@flea>
References: <20180316140215.28663-1-icenowy@aosc.io>
 <20180318201744.dw6hnm2vdybaunev@flea>
Message-ID: <F40271A8-3782-4A69-8C40-3909EB296C66@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?3?19? GMT+08:00 ??4:17:44, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Fri, Mar 16, 2018 at 10:02:06PM +0800, Icenowy Zheng wrote:
>> This patchset adds initial support for the Allwinner H6 SoC.
>> 
>> It's quite different from earlier Allwinner SoCs. For example, the
>> memory map is refactored, and the CCU is rearranged. It's also the
>first
>> Allwinner SoC with PCI Express interface (although the implementation
>> of the PCI Express controller is broken), and the second one with USB
>> 3.0 (the first one is A80).
>> 
>> This patchset adds the most basical support for it, including the
>main pin
>> controller, the main CCU and the basical device tree.
>> 
>> Icenowy Zheng (9):
>>   pinctrl: sunxi: refactor irq related register function to have desc
>>   pinctrl: sunxi: introduce IRQ bank conversion function
>>   pinctrl: sunxi: change irq_bank_base to irq_bank_map
>>   pinctrl: sunxi: add support for the Allwinner H6 main pin
>controller
>>   clk: sunxi-ng: Support fixed post-dividers on NKMP style clocks
>>   dt-bindings: add device tree binding for Allwinner H6 main CCU
>>   clk: sunxi-ng: add support for the Allwinner H6 CCU
>>   arm64: allwinner: h6: add the basical Allwinner H6 DTSI file
>>   arm64: allwinner: h6: add support for Pine H64 board
>
>Applied the !pinctrl patches.

Oops, one clock (CLK_HDMI_SLOW) is missing in the CCU
driver, as Jernej pointed out.

Should I send a patch that fix it?

>
>Thanks!
>Maxime
