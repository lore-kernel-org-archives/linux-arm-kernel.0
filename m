From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Jun 2016 15:09:55 -0700
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxbb: Add Hardware Random
 Generator node
In-Reply-To: <1465546915-24229-4-git-send-email-narmstrong@baylibre.com> (Neil
 Armstrong's message of "Fri, 10 Jun 2016 10:21:55 +0200")
References: <1465546915-24229-1-git-send-email-narmstrong@baylibre.com>
 <1465546915-24229-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <m2ziqoviz0.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index 832815d..8353621 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -167,6 +167,11 @@
>  			};
>  		};
>  
> +		rng {
> +			compatible = "amlogic,meson-rng";
> +			reg = <0x0 0xc8834000 0x0 0x4>;
> +		};

This should be under the periphs bus, with an offset of 0x0 instead of
at the top level.

See the for-next branch in the linux-amlogic tree[1] which has separate
busses for periphs and hiu.

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git
