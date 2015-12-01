From: panand@redhat.com (Pratyush Anand)
Date: Tue, 1 Dec 2015 18:20:21 +0530
Subject: arm64 boot requirements
In-Reply-To: <20151201110159.GA4757@leverpostej>
References: <565BAA2E.5090102@cog.systems> <20151201110159.GA4757@leverpostej>
Message-ID: <20151201125021.GB5704@dhcppc13.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2015:11:02:55 AM, Mark Rutland wrote:
> Pratyush, Geoff, I understood you were loading the kernel vmlinux for
> kexec. Do you parse the Image header to figure out where to place
> things?

Yes, ARM64 kexec-tools supports both elf and binary image loading and in both
the cases text_offset and image_size is calculated from image header. Location
for other segments like initrd or DTB are calculatd accordingly [1]

~Pratyush

[1] http://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/tree/kexec/arch/arm64/kexec-arm64.c#n585
