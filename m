From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 07 Jul 2011 10:28:22 -0700
Subject: [PATCH 0/7] Re-organize linker layouts
In-Reply-To: <20110706102245.GO8286@n2100.arm.linux.org.uk>
References: <20110706102245.GO8286@n2100.arm.linux.org.uk>
Message-ID: <4E15ECB6.40100@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2011 03:22 AM, Russell King - ARM Linux wrote:
> The following series of patches are targetted at two issues:
>
> 1. Fixing large initramfs causing PC24 relocations to become out of
>    range.  This fixes both modules and link-time errors.
>
> 2. Making the vmlinux easier to pinpoint the various section-built
>    data structures and inspect them later.
>
> For the main kernel, this allows the size of various sections to be
> determined via objdump -h.  This also aids objdump -d and -s usage
> when asking it to target a particular section.
>
> For the decompressor, it means that it is now trivially possible to copy
> out the compressed kernel vmlinux image by:
>
>   arm-linux-objcopy -O binary -j .piggydata arch/arm/boot/compressed/vmlinux \
> 	piggy.gz
>
> and thereby obtain the binary kernel image (the Image file) which was
> originally used.

I gave this series a test with my poison initmem patch and all looks well

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

except for patch 2 as I didn't use a zImage.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
