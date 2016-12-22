From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Dec 2016 16:53:08 -0600
Subject: [PATCH 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
In-Reply-To: <20161222041328.3303-5-chris.packham@alliedtelesis.co.nz>
References: <20161222041328.3303-1-chris.packham@alliedtelesis.co.nz>
 <20161222041328.3303-5-chris.packham@alliedtelesis.co.nz>
Message-ID: <20161222225308.4npzerakj2axmbuw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2016 at 05:13:27PM +1300, Chris Packham wrote:
> The Marvell 98DX3236, 98DX3336, 98DX4521 and variants are switch ASICs
> with integrated CPUs. They are similar to the Armada XP SoCs but have
> different I/O interfaces.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/arm/marvell/98dx3236.txt   |  10 +
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi          | 231 +++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |  78 +++++++
>  arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |  78 +++++++
>  4 files changed, 397 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3236.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx3336.dtsi
>  create mode 100644 arch/arm/boot/dts/armada-xp-98dx4251.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt b/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
> new file mode 100644
> index 000000000000..e7dc9b2dd90b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell/98dx3236.txt
> @@ -0,0 +1,10 @@
> +Marvell 98DX3236, 98DX3336 and 98DX4251 Platforms Device Tree Bindings
> +----------------------------------------------------------------------
> +
> +Boards with a SoC of the Marvell 98DX3236, 98DX3336 and 98DX4251 families
> +shall have the following property:
> +
> +Required root node property:
> +
> +compatible: one of "marvell,armadaxp-98dx3236", "marvell,armadaxp-98dx3336"
> +            or "marvell,armadaxp-98dx4251"

The 3336 and 4251 are compatible with 3236 according to the dts files. 
That needs to be expressed here.

Rob
