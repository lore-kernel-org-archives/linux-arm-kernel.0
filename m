From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 20 Feb 2015 13:12:15 +0100
Subject: [PATCH 1/6] ASoC: max98088: Document DT bindings
In-Reply-To: <54E681A8.6040702@suse.de>
References: <1424283959-16289-1-git-send-email-afaerber@suse.de>
 <1424283959-16289-2-git-send-email-afaerber@suse.de>
 <54E5EB36.9020007@collabora.co.uk> <54E5EF73.2090302@suse.de>
 <CAD=FV=VoFnbEsKi4mDDkaTrTXboJmm0UNV5iCk1CvV5ndEZtsA@mail.gmail.com>
 <54E62E1C.4030105@suse.de> <54E6314E.5060509@suse.de>
 <54E64C09.5000505@collabora.co.uk> <54E681A8.6040702@suse.de>
Message-ID: <54E7249F.2020900@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/02/15 01:36, Andreas F?rber wrote:
>>> >> So it seems the mclk is not always set up properly by the kernel,
>>> >> relying on firmware. Who's in charge of setting that clock up?
>> > 
>> > Right, it seems audio is only working due the firmware doing some previous
>> > setup. Probably it works on every boot if you have "sound init" as a part of
>> > the u-boot boot commands?
>
> Indeed it does, 24 MHz without the reparenting patch, and sound working.

You can have parent of the CLKOUT clock set by the clk core if it is
specified in device tree in the PMU (the clkout clock supplier) device
node.

Similarly as we did for the Odroix U3:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/exynos4412-odroid-common.dtsi#n39

Relying on the clk_set_rate() to set the parent clock is not optimal
IMO. Presumably you need to set select stable parent clock for clkout
like XXTI. But I'm not very familiar with exyno5250 and that might be
something different.

-- 
Regards,
Sylwester
