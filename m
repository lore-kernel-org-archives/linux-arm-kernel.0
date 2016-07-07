From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 7 Jul 2016 10:17:47 +0900
Subject: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <2543175.KeBui093Sr@hactar>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-2-takahiro.akashi@linaro.org>
 <2543175.KeBui093Sr@hactar>
Message-ID: <20160707011745.GX20774@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2016 at 03:11:45PM -0300, Thiago Jung Bauermann wrote:
> Am Mittwoch, 06 Juli 2016, 16:52:19 schrieb AKASHI Takahiro:
> > On the startup of primary kernel, the memory region used by crash dump
> > kernel must be specified by "crashkernel=" kernel parameter.
> > reserve_crashkernel() will allocate and reserve the region for later use.
> > 
> > User space tools, like kexec-tools, will be able to find that region
> > marked as "Crash kernel" in /proc/iomem.
> 
> On powerpc, userspace tools get everything from the device tree (exposed to 
> userspace in /proc/device-tree/), not /proc/iomem.

I started my kdump patches with arm (not arm64) implementation, and
so /proc/iomem is used for consistency. Since my kexec-tools (for arm64)
have to access /proc/iomem to identify usable memory regions on
*UEFI* systems anyway, I didn't think it was odd.

(Please note that UEFI won't expose memory regions information via
a device tree, but via ACPI table.)

> In the case of the crashkernel reserved region, that information is in 
> /chosen/linux,crashkernel-base and /chosen/linux,crashkernel-size.
> 
> Either way is fine I think. I'm just mentioning this for reference in case 
> you want the ARM implementation to be closer to another arch which is also 
> based on the device tree.

Adding those properties to a device tree is quite easy
(and it won't conflict with /proc/iomem), so I'd like 
to defer to arm64 maintainers.

Thanks,
-Takahiro AKASHI

> -- 
> []'s
> Thiago Jung Bauermann
> IBM Linux Technology Center
> 
