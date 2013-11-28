From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 16:56:29 +0900
Subject: [PATCH] ARM: shmobile: Include all 4 GiB of memory on Lager
In-Reply-To: <20131031032141.16014.78225.sendpatchset@w520>
References: <20131031032141.16014.78225.sendpatchset@w520>
Message-ID: <20131128075627.GO24146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:21:41PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add 2GiB of DRAM at 0x1_8000_0000 to support the full 4GiB
> of Lager system memory.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  For correct run time operation regardless of kernel configuration
>  ARM patches 7863/1 and 7864/1 are needed.
> 
>  Written on top of renesas-devel-v3.12-rc7-20131030
> 
>  arch/arm/boot/dts/r8a7790-lager.dts |    5 +++++
>  1 file changed, 5 insertions(+)

Thanks, I have queued this up.

> 
> --- 0001/arch/arm/boot/dts/r8a7790-lager.dts
> +++ work/arch/arm/boot/dts/r8a7790-lager.dts	2013-10-31 11:49:43.000000000 +0900
> @@ -24,6 +24,11 @@
>  		reg = <0 0x40000000 0 0x80000000>;
>  	};
>  
> +	memory at 180000000 {
> +		device_type = "memory";
> +		reg = <1 0x80000000 0 0x80000000>;
> +	};
> +
>  	lbsc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> 
