From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 9 Sep 2015 19:22:47 +0100
Subject: [PATCH] arm64: Add support for hardware updates of the access
 and dirty pte bits
In-Reply-To: <55F06A87.3000204@citrix.com>
References: <1436545468-1549-1-git-send-email-catalin.marinas@arm.com>
 <55F06A87.3000204@citrix.com>
Message-ID: <20150909182246.GA1491@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 09, 2015 at 06:21:11PM +0100, Julien Grall wrote:
> Hi Catalin,
> 
> I've tried to boot the latest linus/master (a794b4f) which include this
> patch as DOM0 on xgene. This is failing late in the boot with
> a BUG (see trace below).

FWIW, on Seattle I'm able to boot a defconfig + CONFIG_XEN kernel from
that same commit under Xen 4.6.0-rc2, and it's happy to mount the (ext4)
rootfs, and make -j8 a new kernel. Dom0 memory is set to 1G in my case.

> The bisector pointed me to this patch. When I disable
> CONFIG_ARM64_HW_AFDBM, I'm able to boot the kernel and use it
> without any issue.

Is the failure identical each time (e.g. is it always in the same
location)?

Thanks,
Mark.
