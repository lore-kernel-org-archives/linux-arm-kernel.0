From: lee@kernel.org (Lee Jones)
Date: Fri, 5 Jun 2015 20:23:53 +0100
Subject: [PATCH v7 1/3] dt/bindings: Add binding for the Raspberry Pi
 firmware driver
In-Reply-To: <1433448707-18104-1-git-send-email-eric@anholt.net>
References: <1433448707-18104-1-git-send-email-eric@anholt.net>
Message-ID: <20150605192353.GB3301@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 04 Jun 2015, Eric Anholt wrote:

> This driver will provide support for calls into the firmware that will
> be used by other drivers like cpufreq and vc4.
> 
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: Improve commit message, point to mailbox.txt for how mboxes work.
> v3: Use Lee's suggestion for mailbox phandle docs, fix spelling of
>     "raspberry".
> v4: Change the compatible string to "raspberrypi,bcm2835-firmware"
>     (requested by Lee, agreed by Stephen)
> v5: Add missing s-o-b, fix spelling.
> 
>  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt

Applied for v4.2, thanks.

> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> new file mode 100644
> index 0000000..6824b31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> @@ -0,0 +1,14 @@
> +Raspberry Pi VideoCore firmware driver
> +
> +Required properties:
> +
> +- compatible:		Should be "raspberrypi,bcm2835-firmware"
> +- mboxes:		Phandle to the firmware device's Mailbox.
> +			  (See: ../mailbox/mailbox.txt for more information)
> +
> +Example:
> +
> +firmware {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +};
