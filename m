From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 4 Mar 2014 13:55:12 -0500
Subject: [PATCH 4/4] ARM: mvebu: the Armada XP Matrix board has 4 GB
In-Reply-To: <1393951022-18114-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1393951022-18114-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140304185512.GQ1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 05:37:02PM +0100, Thomas Petazzoni wrote:
> Since the Armada XP Matrix board has 4 GB of RAM and not 2 GB, we
> update the Device Tree to take into account the correct amount of
> memory. As noted in the new comment, the last 256 MB of RAM are in
> fact not usable, due to the overlap with the MBus Window address
> range.

usually the bootloader (DT) or atags_to_fdt overwrites this.  Is there a
scenario when that doesn't happen?

thx,

Jason.

> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-matrix.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
> index e47c49e..c224274 100644
> --- a/arch/arm/boot/dts/armada-xp-matrix.dts
> +++ b/arch/arm/boot/dts/armada-xp-matrix.dts
> @@ -23,7 +23,12 @@
>  
>  	memory {
>  		device_type = "memory";
> -		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
> +		/*
> +		 * This board has 4 GB of RAM, but the last 256 MB of
> +		 * RAM are not usable due to the overlap with the MBus
> +		 * Window address range
> +		 */
> +		reg = <0 0x00000000 0 0xf0000000>;
>  	};
>  
>  	soc {
> -- 
> 1.8.3.2
> 
