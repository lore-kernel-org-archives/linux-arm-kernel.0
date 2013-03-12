From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 12 Mar 2013 11:43:17 +0100
Subject: [PATCH V2 9/9] ARM: dts: tegra: add the PM configurations of PMC
In-Reply-To: <1363061043-9680-1-git-send-email-josephl@nvidia.com>
References: <1363061043-9680-1-git-send-email-josephl@nvidia.com>
Message-ID: <97395805.p014F9TUYL@fb07-iapwap2.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joseph,

Am Dienstag, 12. M?rz 2013, 12:04:03 schrieb Joseph Lo:
> Adding the PM configuration of PMC when the platform support suspend
> function.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> V2:
> * no change
> ---
>  arch/arm/boot/dts/tegra20-harmony.dts   | 6 ++++++
>  arch/arm/boot/dts/tegra20-paz00.dts     | 7 +++++++
>  arch/arm/boot/dts/tegra20-seaboard.dts  | 6 ++++++
>  arch/arm/boot/dts/tegra20-trimslice.dts | 9 +++++++++
>  arch/arm/boot/dts/tegra20-ventana.dts   | 6 ++++++
>  arch/arm/boot/dts/tegra20-whistler.dts  | 8 ++++++++
>  arch/arm/boot/dts/tegra30-beaver.dts    | 7 +++++++
>  arch/arm/boot/dts/tegra30-cardhu.dtsi   | 7 +++++++
>  8 files changed, 56 insertions(+)
> 
> [...]
>
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index 41e82e3..cd8e798 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -415,6 +415,13 @@
> 
>  	pmc {
>  		nvidia,invert-interrupt;
> +		nvidia,suspend-mode = <2>;
> +		nvidia,cpu-pwr-good-time = <5000>;

should be 2000

> +		nvidia,cpu-pwr-off-time = <5000>;

should be 0

> +		nvidia,core-pwr-good-time = <3845 3845>;

mmh, no idea here. original source [1] shows 0x7e7e ticks which translates to 
1 sec?

> +		nvidia,core-pwr-off-time = <3875>;

should be 0

> +		nvidia,sys-clock-req-active-high;
> +		nvidia,combined-power-req;

paz00 has no combined power req.

>  	};
> 
>  	usb at c5000000 {

[1]: http://gitorious.org/ac100/kernel/blobs/2.6.32/arch/arm/mach-tegra/odm_kit/query/paz00/nvodm_query.c#line649

Marc
