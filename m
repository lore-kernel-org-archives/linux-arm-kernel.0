From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 3 Aug 2013 13:36:40 -0400
Subject: [PATCH 3/3] ARM: dts: mvebu: Introduce a new compatible string
 for mv64xxx-i2c
In-Reply-To: <1373898278-4805-4-git-send-email-gregory.clement@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130803173640.GA13555@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 04:24:38PM +0200, Gregory CLEMENT wrote:
> The mv64xxx-i2c embedded in the Armada XP have a new feature to
> offload i2c transaction. This new version of the IP come also with
> some errata. This lead to the introduction to a another compatible
> string.
> 
> This commit split the i2c information into armada-370.dtsi and
> armada-xp.dtsi. Most of the data remains the same and stay in the
> common file Armada-370-xp.dtsi. With this new feature the size of the
> registers are bigger for Armada XP and the new compatible string is
> used.
> 
> The Device Tree binding documentation is updated accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt | 13 ++++++++++++-
>  arch/arm/boot/dts/armada-370-xp.dtsi                  |  2 --
>  arch/arm/boot/dts/armada-370.dtsi                     |  8 ++++++++
>  arch/arm/boot/dts/armada-xp.dtsi                      | 10 ++++++++++
>  4 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> index a1ee681..c5dd952 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-mv64xxx.txt
> @@ -4,7 +4,8 @@
>  Required properties :
>  
>   - reg             : Offset and length of the register set for the device
> - - compatible      : Should be "marvell,mv64xxx-i2c"
> + - compatible      : Should be "marvell,mv64xxx-i2c" and "marvell,mv7230-i2c"
> +for controller which support the I2C Transaction Generator
>   - interrupts      : The interrupt number

As you've preserved backwards compatibility with the original compat
string,

Applied to mvebu/dt

thx,

Jason.
