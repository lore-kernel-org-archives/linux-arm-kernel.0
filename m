From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Jul 2016 09:27:31 +0200
Subject: [PATCH v2 1/6] binding-doc: power: pwrseq-generic: add binding
 doc for generic power sequence library
In-Reply-To: <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
References: <1468375610-18625-1-git-send-email-peter.chen@nxp.com>
 <1468375610-18625-2-git-send-email-peter.chen@nxp.com>
Message-ID: <1468394851.3638.13.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 13.07.2016, 10:06 +0800 schrieb Peter Chen:
> Add binding doc for generic power sequence library.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  .../bindings/power/pwrseq/pwrseq-generic.txt       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> new file mode 100644
> index 0000000..186c58c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-generic.txt
> @@ -0,0 +1,53 @@
> +The generic power sequence library
> +
> +Some hard-wired USB/MMC devices need to do power sequence to let the
> +device work normally,

I would replace "to let the device work normally" with "before the
device can be enumerated [on the bus]" here.

>  the typical power sequence like: enable USB
> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> +lacks of such code to do it, it may cause some hard-wired USB devices
> +works abnormal or can't be recognized by controller at all. The
> +power sequence will be done before this device can be found at USB
> +bus.
> +
> +The power sequence properties is under the device node.
> +
> +Required properties:
> +- power-sequence: this device needs to do power sequence before enumeration

As Joshua pointed out, is this even needed at all?

> +Optional properties:
> +- clocks: the input clock for device.
> +- reset-gpios: Should specify the GPIO for reset.
> +- reset-duration-us: the duration in microsecond for assert reset signal.

With the above two issues sorted out,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
