From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Jun 2016 17:02:01 +0200
Subject: [PATCH 3/3] ARM: dts: armada-38x: fix MBUS_ID for crypto SRAM on
 Armada 385 Linksys
In-Reply-To: <1466084547-31343-4-git-send-email-thomas.petazzoni@free-electrons.com>
 (Thomas Petazzoni's message of "Thu, 16 Jun 2016 15:42:27 +0200")
References: <1466084547-31343-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1466084547-31343-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <87inx99nyu.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., juin 16 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> When the support for the Marvell crypto engine was added in the Device
> Tree of the various Armada 385 Device Tree files in commit
> d716f2e837ac6 ("ARM: mvebu: define crypto SRAM ranges for all armada-38x
> boards"), a typo was made in the MBus window attributes for the Armada
> 385 Linksys board: 0x09/0x05 are used instead of 0x19/0x15. This commit
> fixes this typo, which makes the CESA engines operational on Armada 385
> Linksys boards.
>
> Reported-by: Terry Stockert <stockert@inkblotadmirer.me>
> Cc: Terry Stockert <stockert@inkblotadmirer.me>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: <stable@vger.kernel.org>
> Fixes: d716f2e837ac6 ("ARM: mvebu: define crypto SRAM ranges for all armada-38x boards")
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-385-linksys.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
> index 8450944..22f7a13 100644
> --- a/arch/arm/boot/dts/armada-385-linksys.dtsi
> +++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
> @@ -58,8 +58,8 @@
>  	soc {
>  		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
>  			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
> -			  MBUS_ID(0x09, 0x09) 0 0xf1100000 0x10000
> -			  MBUS_ID(0x09, 0x05) 0 0xf1110000 0x10000>;
> +			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
> +			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
>  
>  		internal-regs {
>  
> -- 
> 2.7.4
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
