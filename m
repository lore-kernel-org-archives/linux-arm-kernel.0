From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Jun 2013 19:03:59 +0200
Subject: [PATCH 2/2] ARM: dts: mvebu: Add the i2c-bridge capability to
 the mv64xxx-i2c
In-Reply-To: <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
References: <1370619743-15245-1-git-send-email-gregory.clement@free-electrons.com>
 <1370619743-15245-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130607170359.GN14209@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Fri, Jun 07, 2013 at 05:42:23PM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature called
> i2c-bridge. This commit split the i2c information into armada-370.dtsi
> and armada-xp.dtsi. Most of the data remains the same and stay in the
> common file Armada-370-xp.dtsi. With this new feature the size of the
> registers are bigger for Armada XP and for this SoCs we add a new flag
> for the i2c-bridge capability.
> 
> The Device Tree binding documentation is updated accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt |  6 ++++++
>  arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
>  arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
>  arch/arm/boot/dts/armada-xp.dtsi                      | 10 ++++++++++
>  4 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index f46d928..8ede3e7 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -8,6 +8,12 @@ Required properties :
>   - interrupts      : The interrupt number
>   - clock-frequency : Desired I2C bus clock frequency in Hz.
>  
> +Optional  properties :
> +
> +- i2c,i2c-bridge : This flag indicate that the i2c controller have the
> +  Transaction Generator support and we want to use it. Not all the
> +  mv64xxx controller have this feature.

Why not using a different compatible string here then?

Maxime
