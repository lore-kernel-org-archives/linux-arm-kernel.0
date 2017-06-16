From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 16 Jun 2017 13:57:51 -0700
Subject: [PATCH v5 3/4] ARM64: dts: meson-gx: use stable UART bindings
 with correct gate clock
In-Reply-To: <1497428957-19942-4-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Wed, 14 Jun 2017 10:29:16 +0200")
References: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
 <1497428957-19942-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2vanvejlc.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> From: Helmut Klein <hgkr.klein@gmail.com>
>
> This patch switches to the stable UART bindings but also add the correct
> gate clock to the non-AO UART nodes for GXBB and GXL SoCs.
>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 12 +++++-------
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 25 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 25 +++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 603491d..86a4018 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -225,7 +225,7 @@
>  			};
>  
>  			uart_A: serial at 84c0 {
> -				compatible = "amlogic,meson-uart";
> +				compatible = "amlogic,meson-gx-uart";

IMO, we should keep both compatibles (the more specific one first.)
That would allow new DTs to continue to run on older kernels.

It would also allow this DT change to be completely independent of the
driver changes.  Otherwise, if I merge this before the driver change are
merged, we'll have a bunch of boards with no more serial console output.

Kevin
