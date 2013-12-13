From: bcm@fixthebug.org (Christian Daudt)
Date: Fri, 13 Dec 2013 00:02:25 -0800
Subject: [PATCH v4 3/8] Documentation: dt: kona-sdhci: Add clocks property
In-Reply-To: <1386271244-3927-4-git-send-email-tim.kryger@linaro.org>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
 <1386271244-3927-4-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYr7DpMhEjp3xd1t21usjWGdod0dsqdsAeu2gyVY-pqQKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> The Kona SDHCI block requires a clock that must be specified in the
> device tree.  Update the documentation to reflect this requirement.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/kona-sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> index 789fb07..aaba248 100644
> --- a/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/kona-sdhci.txt
> @@ -6,12 +6,16 @@ and the properties present in the bcm281xx SDHCI
>  Required properties:
>  - compatible : Should be "brcm,kona-sdhci"
>  - DEPRECATED: compatible : Should be "bcm,kona-sdhci"
> +- clocks: phandle + clock specifier pair of the external clock
> +
> +Refer to clocks/clock-bindings.txt for generic clock consumer properties.
>
>  Example:
>
>  sdio2: sdio at 0x3f1a0000 {
>         compatible = "brcm,kona-sdhci";
>         reg = <0x3f1a0000 0x10000>;
> +       clocks = <&sdio3_clk>;
>         interrupts = <0x0 74 0x4>;
>  };
>
> --
> 1.8.0.1
>
Reviewed-by: Christian Daudt <bcm@fixthebug.org>
