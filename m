From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Feb 2014 16:12:53 +0100
Subject: [PATCH 1/3] ARM: mvebu: use C preprocessor include for Armada
 375/38x DTs
In-Reply-To: <1392894691-26837-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392894691-26837-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392894691-26837-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <53061B75.1040802@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 20/02/2014 12:11, Thomas Petazzoni wrote:
> Some of the Armada 375/38x DTs that were recently submitted were still
> using the old-style /include/ instead of the new-style, C-preprocessor
> based #include. Since we are going to start including more headers,
> switching to the C-preprocessor based includes is important.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-375.dtsi | 2 +-
>  arch/arm/boot/dts/armada-380.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 9f5cb51..c89fee4 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -11,7 +11,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -/include/ "skeleton.dtsi"
> +#include "skeleton.dtsi"
>  
>  #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
>  
> diff --git a/arch/arm/boot/dts/armada-380.dtsi b/arch/arm/boot/dts/armada-380.dtsi
> index 5a46ec7..82b3347 100644
> --- a/arch/arm/boot/dts/armada-380.dtsi
> +++ b/arch/arm/boot/dts/armada-380.dtsi
> @@ -12,7 +12,7 @@
>   * warranty of any kind, whether express or implied.
>   */
>  
> -/include/ "armada-38x.dtsi"
> +#include "armada-38x.dtsi"
>  
>  / {
>  	model = "Marvell Armada 380 family SoC";
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
