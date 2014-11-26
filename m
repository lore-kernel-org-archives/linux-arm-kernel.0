From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 25 Nov 2014 21:33:20 -0800
Subject: [PATCH 0/9] Extend various drivers to run on bi-endian BMIPS hosts
In-Reply-To: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
Message-ID: <CAGVrzcZrOY+y1H_86X1Rj9GvpRhSaYLMw59vZyt84MAkUmEHHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-11-25 16:49 GMT-08:00 Kevin Cernekee <cernekee@gmail.com>:
> This patch series incorporates the following changes:
>
>  - Extend brcmstb reset driver to work on MIPS (currently ARM-only).
>
>  - Extend brcmstb GISB bus driver to work on MIPS (currently ARM-only).
>
>  - Extend brcmstb GISB bus driver to work on BE systems (currently LE-only).
>
>  - Extend both drivers to support the older register layouts used on many
>    of the BMIPS platforms.
>
>  - Extend {ohci,ehci}-platform drivers to accept the new "native-endian"
>    DT property, to accommodate BCM7xxx platforms that can be switched
>    between LE/BE with a board jumper.
>
>
> Dependencies:
>
> power/reset: brcmstb: Register with kernel restart handler (Guenter Roeck)
> of: Add helper function to check MMIO register endianness (Kevin Cernekee)
>
> These are both tentatively accepted, but might not be present in the same
> tree yet.  As such, we might want to "review now, merge later."

For the entire series:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

I will probably take the brcmstb_gisb.c changes separately and submit
them to arm-soc as a "drivers" pull request since this driver has
typically been routed that way.

Thanks!

>
>
> Kevin Cernekee (9):
>   power/reset: brcmstb: Make the driver buildable on MIPS
>   power/reset: brcmstb: Use the DT "compatible" string to indicate bit
>     positions
>   power/reset: brcmstb: Add support for old 65nm chips
>   bus: brcmstb_gisb: Make the driver buildable on MIPS
>   bus: brcmstb_gisb: Introduce wrapper functions for MMIO accesses
>   bus: brcmstb_gisb: Look up register offsets in a table
>   bus: brcmstb_gisb: Add register offset tables for older chips
>   bus: brcmstb_gisb: Honor the "big-endian" and "native-endian" DT
>     properties
>   usb: {ohci,ehci}-platform: Use new OF big-endian helper function
>
>  .../devicetree/bindings/arm/brcm-brcmstb.txt       |   4 +-
>  .../devicetree/bindings/bus/brcm,gisb-arb.txt      |   6 +-
>  Documentation/devicetree/bindings/usb/usb-ehci.txt |   2 +
>  Documentation/devicetree/bindings/usb/usb-ohci.txt |   2 +
>  drivers/bus/Kconfig                                |   2 +-
>  drivers/bus/brcmstb_gisb.c                         | 127 ++++++++++++++++++---
>  drivers/power/reset/Kconfig                        |   9 +-
>  drivers/power/reset/brcmstb-reboot.c               |  41 +++++--
>  drivers/usb/host/ehci-platform.c                   |   2 +-
>  drivers/usb/host/ohci-platform.c                   |   2 +-
>  10 files changed, 161 insertions(+), 36 deletions(-)
>
> --
> 2.1.0
>



-- 
Florian
