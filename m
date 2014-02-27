From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 27 Feb 2014 22:48:30 +0100
Subject: [PATCH 0/4] ARM: dove: move Dove DT to MVEBU
In-Reply-To: <20140227214543.GK1872@titan.lakedaemon.net>
References: <1393536486-3827-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140227214543.GK1872@titan.lakedaemon.net>
Message-ID: <530FB2AE.8020204@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 10:45 PM, Jason Cooper wrote:
> On Thu, Feb 27, 2014 at 10:28:01PM +0100, Sebastian Hesselbarth wrote:
>> Thanks to DT conversion effort, Marvell Dove with DT support is now
>> ready to leave mach-dove and hop into mach-mvebu. As discussed with
>> MVEBU maintainers, we first add dove.c now and keep on migrating
>> it with Armada 3xx SoCs the next cycle.
>>
>> Patch 1 adds a DT node for the system controller found on Marvell
>> MVEBU SoCs.
>>
>> Patch 2 copies an approach taken by Andrew Lunn for Kirkwood-to-MVEBU
>> patches, that add MACH_DOVE for Dove in mach-mvebu to distinguish it
>> from ARCH_DOVE in mach-dove, where drivers still support both non-DT
>> and DT.
>>
>> Patch 3 then moves mach-dove/board-dt.c to mach-mvebu/dove.c with
>> minor cleanups and converts drivers/phy/Kconfig to MACH_DOVE for
>> a DT-only driver.
>>
>> Patch 4 finally adds MACH_DOVE and some of its drivers to multi_v7
>> defconfig.
>>
>> The patches are based on v3.14-rc4, recently posted mvebu/pinctrl-cleanup
>> and mvebu/pinctrl-dove branches: v3.14-rc4 is required for a irqchip
>> driver fix when SPARSE_IRQ is set, the pinctrl branches remove hard-coded
>> addresses from Dove's pinctrl driver.
>
> If I were to base this series on v3.14-rc1, I would need to pull in
>
>    mvebu/pinctrl-dove (which draws in mvebu/pinctrl-cleanup)
>    mvebu/irqchip-fixes
>
> and that should be all.  iiuc, these are boot-time requirements, not
> build or merge requirements, correct?

Yes, all are boot-time requirements only.

Sebastian
