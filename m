From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 07 Mar 2017 18:32:42 +0100
Subject: [PATCH] ARM: dts: mvebu: remove unnecessary PCI range from
 98dx3236
In-Reply-To: <20170302224239.10062-1-chris.packham@alliedtelesis.co.nz> (Chris
 Packham's message of "Fri, 3 Mar 2017 11:42:39 +1300")
References: <20170302224239.10062-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <87varlngat.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,
 
 On jeu., mars 02 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The Marvell 98dx3236 SoC only has a single PCIe x1 interface. The "Port
> 0.1 MEM" range was errantly kept when creating a specific dts for the
> SoC.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> index f6a03dcee5ef..0e63f927c73d 100644
> --- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
> @@ -95,8 +95,7 @@
>  			ranges =
>  			       <0x82000000 0 0x40000 MBUS_ID(0xf0, 0x01) 0x40000 0 0x00002000   /* Port 0.0 registers */
>  				0x82000000 0x1 0       MBUS_ID(0x04, 0xe8) 0 1 0 /* Port 0.0 MEM */
> -				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */
> -				0x82000000 0x2 0       MBUS_ID(0x04, 0xd8) 0 1 0 /* Port 0.1 MEM */>;
> +				0x81000000 0x1 0       MBUS_ID(0x04, 0xe0) 0 1 0 /* Port 0.0 IO  */>;
>  
>  			pcie1: pcie at 1,0 {
>  				device_type = "pci";
> -- 
> 2.11.0.24.ge6920cf
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
