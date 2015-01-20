From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 20 Jan 2015 11:51:14 +0100
Subject: [PATCHv6 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
In-Reply-To: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421665567-31759-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150120115114.45900704@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jan 2015 12:06:01 +0100
Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:

> USB: host: Atmel OHCI and EHCI drivers improvements
> 
> Suspend/resume support for EHCI.
> struct dev_pm_ops for OHCI.
> Removed global variables from both.
> Fixed OHCI wake up support for STANDBY(wake-up enabled) and MEM(wake-up
> disabled) sleep targets.

To the whole series:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> 
> Changes since v5:
>   * Don't overwrite device wakeup flag with device_init_wakeup(),
>     now using a private wakeup bool instead.
> 
> Changes since v4:
>   * Re-add at91_suspend_entering_slow_clock() to OHCI, we can't naively
>     remove this one, this device needs to be continuously clocked to
>     provide wake up support.
>     The removal of at91_suspend_entering_slow_clock() actually lighted up
>     an issue on wake up support, which is now fixed.
> 
> Changes since v3:
>   * Using struct dev_pm_ops instead of static struct platform_driver
>     resume and suspend bindings for both EHCI and OHCI
>   * Fixed inconsistency in patch subjects, _ intead of - for file names
>   * Patch cleaning with the help of checkpatch.pl, fixed lines over
>     80 characters
> 
> Changes since v2:
>   * Added patchs from an other submission, because this series
>     depended on this one
>     * EHCI: Move global variables to private struct
>     * OHCI: Move global variables to private struct
>   * Using ohci->priv and ehci->priv instead of hcd->hcd_priv,
>     which were not the right way to do that
> 
> Changes since v1:
>   * Don't use at91_suspend_entering_slow_clock() on EHCI,
>     we are trying to get read of this of this function
>   * Removed at91_suspend_entering_slow_clock() from OHCI
> 
> Sylvain Rochet (6):
>   USB: host: ehci-atmel: Add suspend/resume support
>   USB: host: ohci-at91: Use struct dev_pm_ops instead of struct
>     platform_driver
>   USB: host: ehci-atmel: Move global variables to private struct
>   USB: host: ohci-at91: Move global variables to private struct
>   USB: host: ohci-at91: usb_hcd_at91_probe(), remove useless stack
>     initialisation
>   USB: host: ohci-at91: Fix wake-up support
> 
>  drivers/usb/host/ehci-atmel.c | 102 +++++++++++++++++++++++++---------
>  drivers/usb/host/ohci-at91.c  | 126 ++++++++++++++++++++++++++----------------
>  2 files changed, 154 insertions(+), 74 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
