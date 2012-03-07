From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Mar 2012 19:08:15 +0100
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20120307180815.GA27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:30 Tue 06 Mar     , Stephen Warren wrote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> if their arch Kconfig allows it, and they desire.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> that some other architectures will also be able to enable it, but I'm
> not familiar enough with any to know which.
I'm going to repeat. I don't think any impromevent here.

with no specific kernel load address the uImage for is useless/

And this no the job of the kernel to build a boot loader specific boot image
format.

And the uImage format here is called the legacy format where now U-Boot
support a new format based on DT format.

Will you plan to add it too?

no sorry I don't think it's the right way to go.

On X86 we boot zImage simply. The new uImage option to do not specify the load
address add nothing more than just boot a zImage for kernel point of view.

Further more on server the vendor will use grub mostly (even on ARM) and will
expect to boot a zImage.

Best Regards,,
J.
