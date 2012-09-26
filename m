From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 26 Sep 2012 10:38:36 +0000
Subject: [RFC PATCH 0/3] ARM: uncompress.h multi-platform enablement
In-Reply-To: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
References: <1348613212-21897-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201209261038.36223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012, Stephen Warren wrote:
> 
> From: Stephen Warren <swarren@nvidia.com>
> 
> Tegra's uncompress and debug-macro.S communicate to each-other. Hence,
> we can't be left without uncompress.h in a multi-platform enabled kernel,
> or we'll lose features. This series allows uncompress.h to be used in a
> multi-platform kernel, restores the mvebu uncompress.h, and finally moves
> the Tegra debug macros into the common location. The series as mainly an
> RFC due to the outstanding question of where to put Tegra's <mach/iomap.h>
> in the final patch.


To follow up on the IRC discussion we had yesterday leading to this patch
set, I had another idea of how to handle the same: Since the decompressor
code is actually fairly separate from the kernel, we could also build
multiple versions of it, and link in the same compressed vmlinux.

We already allow building Image/zImage/uImage from the same vmlinux,
and that could theoretically be extended.

Your approach of course also sounds ok, and we could eventually combine
the two.

	Arnd
