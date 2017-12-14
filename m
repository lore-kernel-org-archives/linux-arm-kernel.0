From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 14 Dec 2017 15:52:56 +0100
Subject: [PATCH v2] ARM64: dts: meson-axg: add ethernet mac controller
In-Reply-To: <20171214030242.113152-1-yixun.lan@amlogic.com>
References: <20171214030242.113152-1-yixun.lan@amlogic.com>
Message-ID: <1513263176.32163.12.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-12-14 at 11:02 +0800, Yixun Lan wrote:
> Add DT info for the stmmac ethernet MAC which found in
> the Amlogic's Meson-AXG SoC, also describe the ethernet
> pinctrl & clock information here.
> 
> This is tested in the S400 dev board which use a RTL8211F PHY,
> and the pins connect to the 'eth_rgmii_y_pins' group.
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

I think it would have been better to split this into 2 patches.
One adding the controller for axg, the other using it in the s400, but maybe
Kevin is OK with it...

> 
> ---
> Changes in v2 since [1]:
>  - rebase to kevin's v4.16/dt64 branch
>  - add Neil's Reviewed-by
>  - move clock info to board.dts instead of in soc.dtsi
>  - drop "meson-axg-dwmac" compatible string, since we didn't use this
>    we could re-add it later when we really need.
>  - note: to make ethernet work properly,it depend on clock & pinctrl[2],
>    to compile the DTS, the patch [3] is required.
>    the code part will be taken via clock & pinctrl subsystem tree.
> 
> [1]
> http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005301.html
> 
> [2]
> http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005735.html
> http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005694.html
> 
> [3]
> http://lists.infradead.org/pipermail/linux-amlogic/2017-December/005738.html
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 11 ++++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 50 ++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 70eca1f8736a..138de3bc7cc8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -20,3 +20,14 @@
>  &uart_AO {
>  	status = "okay";
>  };
> +
> +&ethmac {

We try to keep nodes alphabetically ordered.
Please put ethmac before uart_A0

thx

> 
> 

With all the dependencies sorted out, it works

Tested-by: Jerome Brunet <jbrunet@baylibre.com> 
