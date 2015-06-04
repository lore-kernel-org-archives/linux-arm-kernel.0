From: treding@nvidia.com (Thierry Reding)
Date: Thu, 4 Jun 2015 10:49:03 +0200
Subject: [linux-next] compile fail with "soc/tegra: fuse: Unify Tegra20
 and Tegra30 drivers"
In-Reply-To: <20150603160808.GM29898@windriver.com>
References: <20150603160808.GM29898@windriver.com>
Message-ID: <20150604084902.GL29060@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 03, 2015 at 12:08:08PM -0400, Paul Gortmaker wrote:
> Hi Thierry,
> 
> This commit:
> 
>   commit 436b6428b9cc97f61721f335eb9d8010751a337e
>   Author: Thierry Reding <treding@nvidia.com>
>   Date:   Wed Apr 29 16:54:04 2015 +0200
> 
>     soc/tegra: fuse: Unify Tegra20 and Tegra30 drivers
> 
> in linux-next, in combination with my pending init cleanup
> 
> http://marc.info/?l=linux-kernel&m=143327626201054&w=2
> 
> will cause a compile fail because 43b642 is relying on an
> implicit include of <linux/module.h> to provide the fcn for:
> 
>    +module_platform_driver(tegra_fuse_driver);
> 
> which in turn causes:
> 
> drivers/soc/tegra/fuse/fuse-tegra.c:171:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
> drivers/soc/tegra/fuse/fuse-tegra.c:171:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
> 
> Can you add the include to your tree please?  I think it makes
> more sense to be there vs. me preemptively adding it to mine.

I've squashed a patch from Paul Walmsley into the offending commit and
pushed a new for-next branch of the Tegra tree, so this should be fixed
in the next iteration.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/8f9f61e4/attachment.sig>
