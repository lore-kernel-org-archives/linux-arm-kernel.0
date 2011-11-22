From: marvin24@gmx.de (Marc Dietrich)
Date: Tue, 22 Nov 2011 11:41:57 +0100
Subject: [PATCH 1/5] arm/dt: tegra: Remove /memreserve/ from device-tree
 files
In-Reply-To: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
Message-ID: <2308525.meomQFtUnY@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Monday 21 November 2011 14:44:07 Stephen Warren wrote:
> There are no drivers in the kernel at present which can make use of the
> memory reserved by /memreserve/, so there is no point reserving it. Remove
> /memreserve/ to allow the user more memory. It's also unclear whether any
> future driver would actually require /memreserve/, or allocate memory
> through some other mechanism.

while this gives 512 MB of usable memory on my AC100, it causes some funny 
pictures on the screen ;-) I guess our bootloader (fastboot) already setups 
the frambuffer there (and enables the backlight). I guess it shouldn't be 
harmful as nothing else writes to this memory area. Otherwise you may add that 
the bootloader (or the kernel cmdline supplied by the bootloader) is now 
responsible for the reservation to the description.

Marc

> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/boot/dts/tegra-harmony.dts   |    1 -
>  arch/arm/boot/dts/tegra-paz00.dts     |    1 -
>  arch/arm/boot/dts/tegra-seaboard.dts  |    1 -
>  arch/arm/boot/dts/tegra-trimslice.dts |    1 -
>  arch/arm/boot/dts/tegra-ventana.dts   |    1 -
>  5 files changed, 0 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra-harmony.dts
> b/arch/arm/boot/dts/tegra-harmony.dts index 0e225b8..a802324 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -1,6 +1,5 @@
>  /dts-v1/;
> 
> -/memreserve/ 0x1c000000 0x04000000;
>  /include/ "tegra20.dtsi"
> 
>  / {
> diff --git a/arch/arm/boot/dts/tegra-paz00.dts
> b/arch/arm/boot/dts/tegra-paz00.dts index 15a949f..1cd0cfe 100644
> --- a/arch/arm/boot/dts/tegra-paz00.dts
> +++ b/arch/arm/boot/dts/tegra-paz00.dts
> @@ -1,6 +1,5 @@
>  /dts-v1/;
> 
> -/memreserve/ 0x1c000000 0x04000000;
>  /include/ "tegra20.dtsi"
> 
>  / {
> diff --git a/arch/arm/boot/dts/tegra-seaboard.dts
> b/arch/arm/boot/dts/tegra-seaboard.dts index 88c682a..60724e4 100644
> --- a/arch/arm/boot/dts/tegra-seaboard.dts
> +++ b/arch/arm/boot/dts/tegra-seaboard.dts
> @@ -1,6 +1,5 @@
>  /dts-v1/;
> 
> -/memreserve/ 0x1c000000 0x04000000;
>  /include/ "tegra20.dtsi"
> 
>  / {
> diff --git a/arch/arm/boot/dts/tegra-trimslice.dts
> b/arch/arm/boot/dts/tegra-trimslice.dts index d3d0d20..95117d3 100644
> --- a/arch/arm/boot/dts/tegra-trimslice.dts
> +++ b/arch/arm/boot/dts/tegra-trimslice.dts
> @@ -1,6 +1,5 @@
>  /dts-v1/;
> 
> -/memreserve/ 0x1c000000 0x04000000;
>  /include/ "tegra20.dtsi"
> 
>  / {
> diff --git a/arch/arm/boot/dts/tegra-ventana.dts
> b/arch/arm/boot/dts/tegra-ventana.dts index 3f9abd6..2af12fa 100644
> --- a/arch/arm/boot/dts/tegra-ventana.dts
> +++ b/arch/arm/boot/dts/tegra-ventana.dts
> @@ -1,6 +1,5 @@
>  /dts-v1/;
> 
> -/memreserve/ 0x1c000000 0x04000000;
>  /include/ "tegra20.dtsi"
> 
>  / {
