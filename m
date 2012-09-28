From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 28 Sep 2012 12:31:40 +0200
Subject: [PATCH] ARM: bcm2835: implement machine restart hook
In-Reply-To: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
References: <1348805280-7647-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120928103140.GZ17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:08 Thu 27 Sep     , Stephen Warren wrote:
> Implement the machine restart hook using the SoC's watchdog timer module.
> To support this, define a DT binding for the watchdog module, and add it
> to the device tree.
> 
> The downstream rpi-split branch contains a full watchdog timer driver
> implementation, which also implements the restart hook. However, the
> restart function is largely separate from the watchdog driver, so for
> simplicity, the restart hook is implemented here directly in the main
> machine source file.
> 
> Overall structure (separate setup/restart) functions derived from the
> picoxcell ARM support.
> 
> Watchdog register IO sequence taken from code by Simon Arlott. Note that
> the watchdog module is not documented in BCM2835-ARM-Peripherals.pdf.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
>  .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt     |   13 ++++++
>  arch/arm/boot/dts/bcm2835.dtsi                     |    5 +++
>  arch/arm/mach-bcm2835/bcm2835.c                    |   46 ++++++++++++++++++++
>  3 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
> new file mode 100644
> index 0000000..03138e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
> @@ -0,0 +1,13 @@
> +BCM2835 Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm2835-pm-wdog"
> +- reg : Specifies base physical address and size of the registers.
> +
> +Example:
> +
> +intc: interrupt-controller {
> +	compatible = "brcm,bcm2835-pm-wdog";
it's seems everyone use -wdt

Best Regards,
J.
