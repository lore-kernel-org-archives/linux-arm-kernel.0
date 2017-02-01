From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 1 Feb 2017 21:04:48 +0100
Subject: [PATCH 12/22 v2] ARM: dts: add top-level DT bindings for Cortina
 Gemini
In-Reply-To: <20170201194632.18455-1-linus.walleij@linaro.org>
References: <20170201194632.18455-1-linus.walleij@linaro.org>
Message-ID: <20170201200448.ljvyo4qpkduwoc4h@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/2017 at 20:46:32 +0100, Linus Walleij wrote:
> This adds the top level SoC bindings for Cortina systems Gemini
> platforms.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rename required property "intcon" to "interrupt-controller"
> - Elaborate a bit on the SoC origins
> - Put the example DTS SoC nodes in a soc {} node
> ---
>  Documentation/devicetree/bindings/arm/gemini.txt | 81 ++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/gemini.txt b/Documentation/devicetree/bindings/arm/gemini.txt
> new file mode 100644
> index 000000000000..eb788302d3e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/gemini.txt
> @@ -0,0 +1,81 @@
> +Cortina systems Gemini platforms
> +
> +The Gemini SoC is the project name for an ARMv4 FA525-based SoC originally
> +produced by Storlink Semiconductor around 2005. The company was renamed
> +later renamed Storm Semiconductor. The chip product name is Storlink SL3516.
> +It was derived from earlier products from Storm named SL3316 (Centroid) and
> +SL3512.
> +
> +Storm Semiconductor was acquired by Cortina Systems in 2008 and the SoC was
> +produced and used for NAS and similar usecases. In 2014 Cortina Systems was
> +in turn acquired by Inphi, who seem to have discontinued this product family.
> +
> +Required properties (in root node):
> +	compatible = "cortina,gemini";
> +
> +Required nodes:
> +
> +- syscon: the root node must have a system controller node pointing to the
> +  global control registers, with the compatible string
> +  "cortina,gemini-syscon", "syscon";
> +
> +- timer: the root node must have a timer node pointing to the SoC timer
> +  block, with the compatible string "cortina,gemini-timer"
> +  See: clocksource/cortina,gemini-timer.txt
> +
> +- interrup-controller: the root node must have an interrupt controller

interrupt-controller maybe ? ;)


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
