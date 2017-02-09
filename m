From: briannorris@chromium.org (Brian Norris)
Date: Thu, 9 Feb 2017 12:52:50 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable pstore configs
In-Reply-To: <20170209195646.GA39738@beast>
References: <20170209195646.GA39738@beast>
Message-ID: <20170209205250.GA118863@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's useful to get testing on these features on various boards (e.g., on
KernelCI), and (when they're working) the ramoops feature is extremely
helpful for debugging live systems.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
+ ARM folks
- Linus

>From Kees's recent pull request:

On Thu, Feb 09, 2017 at 11:56:46AM -0800, Kees Cook wrote:
> Hi,
> 
> This pstore regression was just noticed. If I'm too late, this can land
> in v4.11 and -stable, but if the fix window is still open for v4.10, I'd
> love to see this fix pulled for v4.10.
> 
> Thanks!
> 
> -Kees
[...]
> ----------------------------------------------------------------
> Fix pstore regression (boot Oops) when ftrace disabled, from Brian Norris.
> 
> ----------------------------------------------------------------

I expect we aren't getting regular testing coverage (e.g., from
KernelCI, which has a few ARM-based Chromebooks in the lab [1], which
would have trivially caught the bug) because pstore is not enabled on
the multiplatform config that gets used there. Seems like a good idea,
so we can catch regressions like this automatically?

[1] https://kernelci.org/boot/rk3288-veyron-jerry/

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 028d2b70e3b5..74bdb89faff6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -906,6 +906,10 @@ CONFIG_TMPFS=y
 CONFIG_SQUASHFS=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
+CONFIG_PSTORE=y
+CONFIG_PSTORE_CONSOLE=y
+CONFIG_PSTORE_PMSG=y
+CONFIG_PSTORE_RAM=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
-- 
2.11.0.483
