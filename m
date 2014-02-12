From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 12 Feb 2014 08:49:46 +0100
Subject: [PATCH 2/3] ARM: mvebu: use GPIO DT defines in Armada 370/XP
 boards
In-Reply-To: <1392138433-12573-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392138433-12573-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1392138433-12573-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140212074946.GC30814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 06:07:12PM +0100, Thomas Petazzoni wrote:
> Instead of harcoding 0 and 1 for the gpio specifications in the Armada
> 370/XP boards, use the <dt-bindings/gpio/gpio.h> header file and its
> GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW definitions.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-mirabox.dts         | 7 ++++---
>  arch/arm/boot/dts/armada-370-rd.dts              | 3 ++-
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 3 ++-
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 9 +++++----
>  4 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
> index 944e878..2354fe0 100644
> --- a/arch/arm/boot/dts/armada-370-mirabox.dts
> +++ b/arch/arm/boot/dts/armada-370-mirabox.dts
> @@ -9,6 +9,7 @@
>   */
>  
>  /dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
>  #include "armada-370.dtsi"

Hi Thomas

What i did for kirkwood is include both gpio.h and input.h in
kirkwood.dtsi. Quite a few other systems do that, rather than each
.dts file having to include them. However i don't have a strong
opinion.

	Andrew
