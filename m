From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 12:55:19 -0700
Subject: [PATCH V5] kbuild: dtbs_install: new make target
In-Reply-To: <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
References: <1384201760-16785-1-git-send-email-jason@lakedaemon.net>
 <1385062552-9882-1-git-send-email-jason@lakedaemon.net>
Message-ID: <528E6527.50904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2013 12:35 PM, Jason Cooper wrote:
> Unlike other build products in the Linux kernel, there is no 'make
> *install' mechanism to put devicetree blobs in a standard place.
> 
> This patch is an attempt to fix this problem.  Akin to 'make install',
> this creates a new make target, dtbs_install.  The script that gets
> called defers to a distribution or user supplied installdtbs binary,
> if found in the system.  Otherwise, the default action is to install a
> given dtb into
> 
>   /boot/devicetrees/${kernel_version}/${dts_filename}.dtb
> 
> This is done to keep dtbs from different kernel versions separate until
> things have settled down.  Once the dtbs are stable, and not so strongly
> linked to the kernel version, the devicetree files will most likely move
> to their own repo.  Users will need to upgrade install scripts at that
> time.

Acked-by: Stephen Warren <swarren@nvidia.com>
