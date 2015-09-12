From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 12 Sep 2015 12:58:51 -0700
Subject: [PATCH 2/7] Documentation: dt: brcmstb: add waketimer
 documentation
In-Reply-To: <1434672696-13632-3-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
 <1434672696-13632-3-git-send-email-computersforpeace@gmail.com>
Message-ID: <55F483FB.1010109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/18/15 17:11, Brian Norris a ?crit :
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Although the binding looks good to me, I am not applying this one just
yet since we would want to merge the wake-timer driver and its binding
at the same time, thanks!

> ---
>  .../bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt  | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt
> 
> diff --git a/Documentation/devicetree/bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt b/Documentation/devicetree/bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt
> new file mode 100644
> index 000000000000..68c4329b6af0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/brcmstb/brcm,brcmstb-waketimer.txt
> @@ -0,0 +1,20 @@
> +* Broadcom STB Wake-up Timer
> +
> +The Broadcom STB wake-up timer provides a high-resolution timer, with the
> +ability to wake up the system from low-power suspend/standby modes.
> +
> +Required properties:
> +- compatible     : should contain "brcm,brcmstb-waketimer"
> +- reg            : the register start and length for the WKTMR block
> +- interrupts     : The TIMER interrupt
> +- interrupt-parent: The phandle to the Always-On (AON) Power Management (PM) L2
> +                    interrupt controller node
> +
> +Example:
> +
> +waketimer at f0411580 {
> +	compatible = "brcm,brcmstb-waketimer";
> +	reg = <0xf0411580 0x14>;
> +	interrupts = <0x3>;
> +	interrupt-parent = <&aon_pm_l2_intc>;
> +};
> 


-- 
Florian
