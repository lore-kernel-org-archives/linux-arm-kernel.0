From: robh@kernel.org (Rob Herring)
Date: Sun, 30 Oct 2016 15:42:02 -0500
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <20161024164634.4330-10-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
Message-ID: <20161030204202.7t6qcwin7b5qi2ia@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 06:46:26PM +0200, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> Some regulator supplies have an over-current pin that is
> activated when the hw detects an over current condition.
> When this happens, the hardware enters a current limited
> mode.
> 
> Extend the fixed regulator driver with the ability
> to handle irq's from the over-current pin and report
> an over current event to the consumers via a regulator
> notifier. Also, add device tree bindings to allow to
> pass a gpio for over current monitoring.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> ---
>  .../bindings/regulator/fixed-regulator.txt         |  4 ++
>  drivers/regulator/fixed.c                          | 64 ++++++++++++++++++++++
>  include/linux/regulator/consumer.h                 |  5 ++
>  include/linux/regulator/fixed.h                    |  3 +
>  4 files changed, 76 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> index 4fae41d..d20bf67 100644
> --- a/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.txt
> @@ -11,6 +11,8 @@ If this property is missing, the default assumed is Active low.
>  - gpio-open-drain: GPIO is open drain type.
>    If this property is missing then default assumption is false.
>  -vin-supply: Input supply name.
> +- oc-gpio: Input gpio that signals an over current condition

"-gpios" is the preferred form. So "oc-gpios".

> +- oc-active-high: The polarity of the over current pin is high

This should be specified in the gpio flags cell.

Rob
