From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 5 Apr 2012 01:43:45 -0300
Subject: [3.3] vfs_read oops in
 arm/arch/plat-mxc/audmux-v2.c:audmux_read_file() in sysfs
In-Reply-To: <2d33222231d2b5e5b07a63ae117048c9@mail.fqingenieria.es>
References: <2d33222231d2b5e5b07a63ae117048c9@mail.fqingenieria.es>
Message-ID: <CAOMZO5A6kQ2_-tbfyiigE3K9B2e3CM74OBfsDq4uT3kOgheiiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 10:56 AM, joancarles <joancarles@fqingenieria.es> wrote:
> Hi
>
> A 'cat /sys/kernel/debug/audmux/ssi7' causes following oops to be printed by
> the kernel:

Hmm, ssi7 should not exist.

Please try this:

--- a/sound/soc/imx/imx-audmux.c
+++ b/sound/soc/imx/imx-audmux.c
@@ -158,7 +158,7 @@ static void __init audmux_debugfs_init(void)
                return;
        }

-       for (i = 1; i < 8; i++) {
+       for (i = 0; i < 6; i++) {
                snprintf(buf, sizeof(buf), "ssi%d", i);
                if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
                                         (void *)i, &audmux_debugfs_fops))
