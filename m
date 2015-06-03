From: lee@kernel.org (Lee Jones)
Date: Wed, 3 Jun 2015 22:30:46 +0100
Subject: [PATCH v6 1/3] dt/bindings: Add binding for the Raspberry Pi
 firmware driver
In-Reply-To: <1432928535-27522-1-git-send-email-eric@anholt.net>
References: <1432928535-27522-1-git-send-email-eric@anholt.net>
Message-ID: <20150603213046.GE12304@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What's going on here?  This is unlike you.

> This driver will provide support for calls into the firmware that will
> be used by other drivers like cpufreq and vc4.
> 
> v2: Improve commit message, point to mailbox.txt for how mboxes work.
> v3: Use Lee's suggestion for mailbox phandle docs, fix spelling of
>     "raspberry".
> v4: Change the compatible string to "raspberrypi,bcm2835-firmware"
>     (requested by Lee, agreed by Stephen)

Perhaps this should have culminated in a Suggested-by.

The change-log should be below the "---".

> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Where's your SoB?

> ---
>  .../bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> new file mode 100644
> index 0000000..5fb1868
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> @@ -0,0 +1,14 @@
> +Raspberry Pi VideoCore firmware driver
> +
> +Required properties:
> +
> +- compatible:		Should be "rasbperrypi,bcm2835-firmware"

Spelling.

> +- mboxes:		Phandle to the firmware device's Mailbox.
> +			  (See: ../mailbox/mailbox.txt for more information)
> +
> +Example:
> +
> +firmware {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +};
