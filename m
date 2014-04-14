From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 11:43:02 +0200
Subject: [PATCH 09/29] ARM: orion5x: switch to preprocessor includes in DT
In-Reply-To: <1397400006-4315-10-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-10-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <534BADA6.4070408@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2014 04:39 PM, Thomas Petazzoni wrote:
> This commit switches the Orion5x Device Tree files to use C
> preprocessor based includes, as it will allow us to use definitions
> from header files in future commits.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts | 3 ++-
>   arch/arm/boot/dts/orion5x.dtsi                            | 2 +-
>   2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> index 5ed6c13..0245bb3 100644
> --- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> +++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
> @@ -7,7 +7,8 @@
>    */
>
>   /dts-v1/;
> -/include/ "orion5x.dtsi"
> +
> +#include "orion5x.dtsi"
>
>   / {
>   	model = "LaCie Ethernet Disk mini V2";
> diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
> index da57fb9..2364e3d 100644
> --- a/arch/arm/boot/dts/orion5x.dtsi
> +++ b/arch/arm/boot/dts/orion5x.dtsi
> @@ -6,7 +6,7 @@
>    * warranty of any kind, whether express or implied.
>    */
>
> -/include/ "skeleton.dtsi"
> +#include "skeleton.dtsi"
>
>   / {
>   	model = "Marvell Orion5x SoC";
>
