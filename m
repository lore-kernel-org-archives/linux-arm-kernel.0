From: bauerman@linux.vnet.ibm.com (Thiago Jung Bauermann)
Date: Wed, 06 Jul 2016 15:11:45 -0300
Subject: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20160706075226.27609-2-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-2-takahiro.akashi@linaro.org>
Message-ID: <2543175.KeBui093Sr@hactar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 06 Juli 2016, 16:52:19 schrieb AKASHI Takahiro:
> On the startup of primary kernel, the memory region used by crash dump
> kernel must be specified by "crashkernel=" kernel parameter.
> reserve_crashkernel() will allocate and reserve the region for later use.
> 
> User space tools, like kexec-tools, will be able to find that region
> marked as "Crash kernel" in /proc/iomem.

On powerpc, userspace tools get everything from the device tree (exposed to 
userspace in /proc/device-tree/), not /proc/iomem.

In the case of the crashkernel reserved region, that information is in 
/chosen/linux,crashkernel-base and /chosen/linux,crashkernel-size.

Either way is fine I think. I'm just mentioning this for reference in case 
you want the ARM implementation to be closer to another arch which is also 
based on the device tree.

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
