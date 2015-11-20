From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 10:14:15 -0600
Subject: [PATCH 3/3] devicetree: add rpi power domain driver bindings
In-Reply-To: <1447956490-22930-4-git-send-email-alex.aring@gmail.com>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com>
 <1447956490-22930-4-git-send-email-alex.aring@gmail.com>
Message-ID: <20151120161415.GA27944@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 07:08:10PM +0100, Alexander Aring wrote:
> This patch adds devicetree tree bindings for the Raspberry Pi power
> domain driver.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> new file mode 100644
> index 0000000..c3abc24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
> @@ -0,0 +1,25 @@
> +Raspberry Pi power domain driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-power".
> +- firmware:		Reference to the RPi firmware device node.
> +- #power-domain-cells:	Should be <1>, we providing multiple power domains.
> +
> +The valid defines for power domain are:
> +
> + RPI_POWER_DOMAIN_USB
> +
> +Example:
> +
> +power: power {
> +	compatible = "raspberrypi,bcm2835-power";
> +	firmware = <&firmware>;
> +	#power-domain-cells = <1>;
> +};
> +
> +Example for using power domain:
> +
> +&usb {
> +       power-domains = <&power RPI_POWER_DOMAIN_USB>;
> +};
> -- 
> 2.6.1
> 
