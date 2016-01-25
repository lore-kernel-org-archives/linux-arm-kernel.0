From: jonathanh@nvidia.com (Jon Hunter)
Date: Mon, 25 Jan 2016 15:57:00 +0000
Subject: [PATCH V2] ARM64: tegra: Add chosen node for tegra132 norrin
In-Reply-To: <1453737310-11391-1-git-send-email-jonathanh@nvidia.com>
References: <1453737310-11391-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <56A645CC.5070907@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 25/01/16 15:55, Jon Hunter wrote:
> The NVIDIA bootloader, nvtboot, expects the "chosen" node to be present
> in the device-tree blob and if it is not then it fails to boot the kernel.
> Add the chosen node so we can boot the kernel on Tegra132 Norrin with the
> nvtboot bootloader.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> Ideally, we would like to get this into v4.5 as a fix for Tegra132 Norrin
> so that we can enable booting this board as part of our automated testing
> setup for Tegra [0][1]. Thierry suggested I send this directly as a fix
> to ARM-SOC. Let me know if this is ok. I have not included a "fixes" as it
> may not be needed for all bootloaders, but if you need this we could put:
> 
> Fixes: 0f279eb arm64: tegra: Add NVIDIA Tegra132 Norrin support
> 
> [0] http://nvtb.github.io/linux/
> [1] http://nvtb.github.io/linux-next/

Forgot to mentioned that the differences for v1 -> v2 are just some
minor corrections to the commit message.

Jon

>  arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> index 7dfe1c085966..62f33fc84e3e 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
> @@ -12,6 +12,8 @@
>  		rtc1 = "/rtc at 0,7000e000";
>  	};
>  
> +	chosen { };
> +
>  	memory {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x0 0x80000000>;
> 
