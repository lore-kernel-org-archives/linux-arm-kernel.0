From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 28 May 2015 15:46:46 -0600
Subject: [PATCH 1/7] dt/bindings: Add binding for the Raspberry Pi clock
 provider
In-Reply-To: <1431978219-14226-2-git-send-email-eric@anholt.net>
References: <1431978219-14226-1-git-send-email-eric@anholt.net>
 <1431978219-14226-2-git-send-email-eric@anholt.net>
Message-ID: <55678CC6.8060300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2015 01:43 PM, Eric Anholt wrote:
> The hardware clocks are not controllable by the ARM, so we have to
> make requests to the firmware to do so from the VPU side.  This will
> let us replace fixed clocks in our DT with actual clock control (and
> correct frequency information).

> diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt b/Documentation/devicetree/bindings/clock/raspberrypi,firmware-clocks.txt

> +Required properties:
...
> +- #clock-cells:	Shall have value <1>.  The permitted clock-specifier values
> +		  can be found in include/dt-bindings/clk/raspberrypi.h.

That file is explicitly part of the binding; any driver that implements
this binding needs to use the same values. As such, that file would
typically be part of the patch that adds the binding doc, not part of
the patch that implements the driver.

No need to respin the series just because of that though.

> +- firmware:	Phandle to the firmware driver node.

"firmware" is rather generic. I'd suggest a vendor prefix for the
property name; raspberrypi,firmware.
