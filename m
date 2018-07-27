From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Jul 2018 07:03:54 +0100
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
In-Reply-To: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
References: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <20180727060354.GA4628@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jul 2018, Neil Armstrong wrote:

> The order between "syscon" and "simple-mfd" is important because in these
> particular cases, the node needs to be first a "simple-mfd" to expose
> it's sub-nodes, and later on a "syscon" to permit other nodes to access
> this register space through the "syscon" mechanism.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> This also has a consequence for U-Boot since the U-Boot DM is much simpler
> and can only associate a single device to a node, thus here we want these
> nodes to be an mfd bus to be able to probe the sub-nodes.
> 
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6adc8d3..3f0de9d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -342,7 +342,7 @@
>  			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
>  
>  			sysctrl: system-controller at 0 {
> -				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
> +				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";

I must profess, I haven't looked at the code recently so can't really
comment on the semantics - I'll leave that to Rob et. al.

However, if the ordering is important, you should add a comment to
prevent anyone re-jigging it or reverting the patch for some reason.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
