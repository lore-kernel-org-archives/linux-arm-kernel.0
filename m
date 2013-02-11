From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 11 Feb 2013 11:40:40 +0000
Subject: [PATCH v2 01/14] usb: phy: nop: Add device tree support and
 binding information
In-Reply-To: <1360252974-7912-2-git-send-email-rogerq@ti.com>
References: <1360252974-7912-1-git-send-email-rogerq@ti.com>
 <1360252974-7912-2-git-send-email-rogerq@ti.com>
Message-ID: <20130211114040.GA2726@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Feb 07, 2013 at 04:02:41PM +0000, Roger Quadros wrote:
> The PHY clock, clock rate, VCC regulator and RESET regulator
> can now be provided via device tree.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++++++++
>  drivers/usb/otg/nop-usb-xceiv.c                    |   36 +++++++++++++++----
>  2 files changed, 62 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> new file mode 100644
> index 0000000..d7e2726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -0,0 +1,34 @@
> +USB NOP PHY
> +
> +Required properties:
> +- compatible: should be usb-nop-xceiv

This might be better as "linux,usb-no-xceiv", given this is a Linux-specific
'device'.

Saying that, I'm not sure I understand why this device needs to be instantiated
from devicetree. As I understand it from looking at the driver, it's purely a
Linux implementation detail used in the case of autonomous PHYs, and not an
actual piece of hardware or firmware system. I must admit to being unfamiliar
with this area of hardware, have I misunderstood somethign here?

Can we not have drivers for autonomous PHYs initialise/register nop-usb-xceiv?
That way we don't leak Linux implementation details to the outside world, and
the dt can describe purely what's actually present in the system.

[...]

Thanks,
Mark.
