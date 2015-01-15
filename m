From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Jan 2015 10:45:14 +0000
Subject: [PATCH] Build a uImage with dtb already appended
In-Reply-To: <1421287693-23383-1-git-send-email-ottxor@gentoo.org>
References: <20110802143148.21599.22870.stgit@ponder>
 <1421287693-23383-1-git-send-email-ottxor@gentoo.org>
Message-ID: <20150115104514.GD12302@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 07:08:13PM -0700, Christoph Junghans wrote:
> Add new targets to build zImage and uImage with DTB appended (i.e. make
> 'uImage-dtb.am335x-bone' or 'make zImage-dtb.omap3-evm').
> 
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
> Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
> ---
> 
> I don't know why this never got merged, but I think it is still useful.

What do you do about supplying the load address argument to mkimage,
which is highly platform specific?

This may be useful if you want to create one uImage for one platform,
but it's not useful in other cases.

However, in general, I don't want to augment the u-boot crap that we
already have in the kernel; it's too inflexible.  You're much better
off taking the zImage and DTB, combining them yourself, and then
_if_ you insist on using the u-boot legacy format, running mkimage.

The alternative is to move forward with your uboot skills, and see
whether your uboot supports loading the fdt and use bootz with the
zImage instead of bootm.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
