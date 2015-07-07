From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 7 Jul 2015 11:42:25 +0100
Subject: [linux-sunxi] Re: [PATCH v3 3/4] mfd: axp20x: Add a cell for the
 usb power_supply part of the axp20x PMICs
In-Reply-To: <559BA0BC.9060409@redhat.com>
References: <1435316357-26606-1-git-send-email-hdegoede@redhat.com>
 <1435316357-26606-3-git-send-email-hdegoede@redhat.com>
 <20150707070128.GI3182@x1> <559BA0BC.9060409@redhat.com>
Message-ID: <20150707104225.GS3182@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 07 Jul 2015, Hans de Goede wrote:
> On 07-07-15 09:01, Lee Jones wrote:
> >On Fri, 26 Jun 2015, Hans de Goede wrote:
> >
> >>Add a cell for the usb power_supply part of the axp20x PMICs.
> >>
> >>Note that this cell is only for the usb power_supply part and not the
> >>ac-power / battery-charger / rtc-backup-bat-charger bits.
> >>
> >>Depending on the board each of those must be enabled / disabled separately
> >>in devicetree as most boards do not use all 4. So in dt each one needs its
> >>own child-node of the axp20x node. Another reason for using separate child
> >>nodes for each is so that other devicetree nodes can have a power-supply
> >>property with a phandle referencing a node representing a single
> >>power-supply.
> >>
> >>The decision to use a separate devicetree node for each is reflected on
> >>the kernel side by each getting its own mfd-cell / platform_device and
> >>platform-driver.
> >>
> >>Note this commit also makes some whitespace changes to the intialization
> >>of existing cells in axp20x_cells, these are pure whitespace changes,
> >>functionally nothing changes.
> >>
> >>Cc: Bruno Pr?mont <bonbons@linux-vserver.org>
> >>Acked-by: Lee Jones <lee.jones@linaro.org>
> >>Signed-off-by: Bruno Pr?mont <bonbons@linux-vserver.org>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>Changes in v2:
> >>-Use DEFINE_RES_IRQ_NAMED
> >>-Change indentation of axp20x_cells initializers to avoid line wrapping
> >>Changes in v3:
> >>-Improve commit message
> >>-Add Bruno's S-o-b
> >>---
> >>  drivers/mfd/axp20x.c | 20 ++++++++++++++++----
> >>  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> >For my own reference:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> >
> >Are these two patches tied to any other in the set, or can I apply
> >them separately?
> 
> You can apply them seperately, thanks.
> 
> I'm wondering who will take care of upstreaming the first patch of this
> set: "ARM: dts: Add binding documentation for AXP20x pmic usb power supply"
> 
> If you can take that one too that would be great.

I can do, but I need an Ack from these guys:

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre@kernel.org>
M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
M:      David Woodhouse <dwmw2@infradead.org>
L:      linux-pm at vger.kernel.org
T:      git git://git.infradead.org/battery-2.6.git
S:      Maintained
F:      include/linux/power_supply.h
F:      drivers/power/

... failing that, they should take it.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
