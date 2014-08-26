From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 27 Aug 2014 00:26:08 +0200
Subject: [PATCH] ARM: tegra: add PCIe-related pins to the Jetson TK1 pinmux
 tables
In-Reply-To: <53FB27AB.8010608@nvidia.com>
References: <1408742308-18004-1-git-send-email-swarren@wwwdotorg.org>
 <53FB10B8.3010408@suse.de> <53FB160F.6000700@nvidia.com>
 <53FB27AB.8010608@nvidia.com>
Message-ID: <53FD0980.2010803@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 25.08.2014 14:10, schrieb Mikko Perttunen:
> On 25/08/14 13:55, Mikko Perttunen wrote:
>> On 25/08/14 13:32, Andreas F?rber wrote:
>>> Am 22.08.2014 23:18, schrieb Stephen Warren:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>>
>>>> This pinmux tables currently omit any configuration for PCIe clk_req,
>>>> wake, and rst pins, which in turn causes intermittent failures in
>>>> U-Boot's PCIe support. Import an updated version of the pinmux tables
>>>> which rectifies this.
>>>>
>>>> (While I'm still hoping to remove the pinmux tables from DTs for
>>>> Tegra124+ devices, while they're still here, they may as well be
>>>> complete and correct).
>>>>
>>>> Signed-off-by: Stephen Warren <swarren@nvidia.com>
>>>> ---
>>>>   arch/arm/boot/dts/tegra124-jetson-tk1.dts | 35
>>>> +++++++++++++++++++++++++++++++
>>>>   1 file changed, 35 insertions(+)
>>>
>>> I've tested this patch on both -rc1 and yesterday's torvalds/linux.git
>>> with tegra_defconfig: Both with or without this patch I get empty lspci
>>> output.
>>>
>>> There doesn't seem to be a tegra/linux.git for-next branch based on -rc1
>>> yet - are patches from other subsystem trees needed to get the on-board
>>> Ethernet detected or maybe some config option?
>>
>> git://gitorious.org/thierryreding/linux.git staging/pci
>
> .. and apparently the device tree patches are in staging/tegra.

Thanks for the URLs. I tested yesterday's staging/master, but booting
from SD seemed broked, sdhci-tegra probe kept deferring. Is that a known
issue?

PCI bus was getting detected okay before that point though.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
