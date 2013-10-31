From: horms@verge.net.au (Simon Horman)
Date: Thu, 31 Oct 2013 13:20:37 +0900
Subject: [PATCH] ARM: shmobile: Include all 2 GiB of memory on APE6EVM
In-Reply-To: <20131031031549.15985.23547.sendpatchset@w520>
References: <20131031031549.15985.23547.sendpatchset@w520>
Message-ID: <20131031042035.GG1603@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 12:15:49PM +0900, Magnus Damm wrote:
> From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> 
> Add 1GiB of DRAM at 0x2_0000_0000 to support the full 2GiB
> of APE6EVM system memory.
> 
> Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  For correct run time operation regardless of kernel configuration
>  ARM patches 7863/1 and 7864/1 are needed.

I take it that I should wait for those patches before applying this one.

With those two patches and this one applied on top of
renesas-devel-v3.12-rc7-20131030 I was able to successfully
boot an ape6evm board. But /proc/meminfo still indicates only 1Gb of
memory. What am I missing.

> 
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ work/arch/arm/boot/dts/r8a73a4-ape6evm.dts	2013-10-31 11:44:53.000000000 +0900
> @@ -24,6 +24,11 @@
>  		reg = <0 0x40000000 0 0x40000000>;
>  	};
>  
> +	memory at 200000000 {
> +		device_type = "memory";
> +		reg = <2 0x00000000 0 0x40000000>;
> +	};
> +
>  	ape6evm_fixed_3v3: fixedregulator at 0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "3V3";
> 
