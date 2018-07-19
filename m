From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 19 Jul 2018 16:27:56 +0530
Subject: [PATCH v2 2/2] arm64: dts: Add Mediatek X20 Development Board
 support
In-Reply-To: <e60134a3-0bd6-fadb-3ed4-1db28d6543cc@gmail.com>
References: <20180605163442.4812-1-manivannan.sadhasivam@linaro.org>
 <20180605163442.4812-3-manivannan.sadhasivam@linaro.org>
 <d88504b4-409c-c42b-f816-bedefce2a819@gmail.com>
 <20180717140453.GA19076@mani>
 <a48b0735-ff75-6228-22ba-c8e868240f0c@gmail.com>
 <20180718164304.GA4902@Mani-XPS-13-9360>
 <e60134a3-0bd6-fadb-3ed4-1db28d6543cc@gmail.com>
Message-ID: <20180719105756.GA6106@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2018 at 11:03:54AM +0200, Matthias Brugger wrote:
> 
> 
> On 18/07/18 18:43, Manivannan Sadhasivam wrote:
> > Hi Matthias,
> > 
> > On Wed, Jul 18, 2018 at 05:07:38PM +0200, Matthias Brugger wrote:
> >>
> >>
> >> On 17/07/18 16:04, Manivannan Sadhasivam wrote:
> >>> Hi Matthias,
> >>>
> >>> On Mon, Jul 16, 2018 at 03:24:44PM +0200, Matthias Brugger wrote:
> >>>> Hi Manivanna,
> >>>>
> >>>> On 05/06/18 18:34, Manivannan Sadhasivam wrote:
> >>>>> Add initial device tree support for Mediatek X20 Development Board
> >>>>> based on MT6797 Deca core SoC. This board is one of the 96Boards
> >>>>> Consumer Edition platform.
> >>>>>
> >>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>>>> ---
> >>>>>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >>>>>  .../boot/dts/mediatek/mt6797-x20-dev.dts      | 33 +++++++++++++++++++
> >>>>>  2 files changed, 34 insertions(+)
> >>>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>>
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> index ac17f60f998c..5b7fd6ad96e4 100644
> >>>>> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >>>>> @@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
> >>>>> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
> >>>>>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> >>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>> new file mode 100644
> >>>>> index 000000000000..2c09ca95d9e2
> >>>>> --- /dev/null
> >>>>> +++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
> >>>>> @@ -0,0 +1,33 @@
> >>>>> +// SPDX-License-Identifier: GPL-2.0
> >>>>> +/*
> >>>>> + * Device Tree Source for MediaTek X20 Development Board
> >>>>> + *
> >>>>> + * Copyright (C) 2018, Linaro Ltd.
> >>>>> + *
> >>>>> + */
> >>>>> +
> >>>>> +/dts-v1/;
> >>>>> +
> >>>>> +#include "mt6797.dtsi"
> >>>>> +
> >>>>> +/ {
> >>>>> +	model = "Mediatek X20 Development Board";
> >>>>> +	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
> >>>>> +
> >>>>> +	aliases {
> >>>>> +		serial0 = &uart1;
> >>>>> +	};
> >>>>
> >>>> Sorry for the late answer.
> >>>> Why did you use uart1 instead of uart0?
> >>>> I know that uart0 is used by the bootloader, but because of their exotic flash
> >>>> procedure I find it quite useful to see this messages in my serial connection.
> >>>> Of course you can only use 921600 baudrate then.
> >>>>
> >>>
> >>> The reason is, most of the Mezzanine boards use USB to UART bridge on the
> >>> UART1 port available on the Low Speed Expansion header. Additionally, the
> >>> convention followed by most of the Consumer Edition 96Boards is to use UART1
> >>> as the debug serial port. That's why eventhough the bootloader is using UART0,
> >>> I forced the kernel to use UART1.
> >>>
> >>
> >> Sounds reasonable, I don't have this 96 boards adapter and I forgot about it.
> >>
> > 
> > That's fine :)
> > 
> >>>>> +
> >>>>> +	memory at 40000000 {
> >>>>> +		device_type = "memory";
> >>>>> +		reg = <0 0x40000000 0 0x1e605000>;
> >>>>
> >>>> How comes this strange number for the memory size?
> >>>>
> >>>
> >>> Actually, the memory size is extracted from the downstream kernel [1].
> >>>
> >>
> >> Hm, Archermind "Helio X20 Development Board Hardware Manual" talks about 2GB
> >> LPDDR3-SDRAM. Would you mind to check if that is actually true?
> >>
> > 
> > Yes, it is 2GB. Shall I change the size to 0x80000000?
> > 
> 
> Best would be if you boot the machine with this value and see if things look
> sane. Then resubmit. The other option is to resubmit and I'll check it tomorrow :)
> 

Tested with the modified size, 0x80000000. Board is booting without any issues, so
pushed out the v3.

Thanks,
Mani

> Let me know if you can't do it for tomorrow morning. I plan to submit the pull
> requests tomorrow as I'm through nearly all open patches (yes, two days earlier
> \o/ )
> 
> Best regards,
> Matthias
> 
> > Thanks,
> > Mani
> > 
> >>>> BTW do you know the differences between the EVB board and the x20 one?
> >>>> I used the evb dts for booting up to now.
> >>>>
> >>>
> >>> Sorry, I don't know the difference between both boards!
> >>
> >> Sure, no problem :)
> >>
> >> Regards,
> >> Matthias
> >>
> >>>
> >>> Thanks,
> >>> Mani
> >>>
> >>> [1] https://github.com/helio-x20/linux/blob/helio-x20/arch/arm64/boot/dts/amt6797_64_open.dts#L8
> >>>
> >>>> Best regards,
> >>>> Matthias
> >>>>
> >>>>> +	};
> >>>>> +
> >>>>> +	chosen {
> >>>>> +		stdout-path = "serial0:115200n8";
> >>>>> +	};
> >>>>> +};
> >>>>> +
> >>>>> +&uart1 {
> >>>>> +	status = "okay";
> >>>>> +};
> >>>>>
