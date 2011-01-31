From: will.deacon@arm.com (Will Deacon)
Date: Mon, 31 Jan 2011 19:25:25 -0000
Subject: [PATCH] ARM: add Versatile Express defconfig
In-Reply-To: <1296501243-28917-1-git-send-email-linus.walleij@linaro.org>
References: <1296501243-28917-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <002901cbc17c$9c84b780$d58e2680$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> Being able to compile a major reference platform is helpful for
> me when developing on other archs using the same e.g. PrimeCells.
> I bet this is useful to others as well.

Ignoring the politics surrounding defconfigs, I have a comment inline...
 
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> new file mode 100644
> index 0000000..f2de51f
> --- /dev/null
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -0,0 +1,140 @@
> +CONFIG_EXPERIMENTAL=y
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_SYSVIPC=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_LOG_BUF_SHIFT=14
> +CONFIG_CGROUPS=y
> +CONFIG_CPUSETS=y
> +# CONFIG_UTS_NS is not set
> +# CONFIG_IPC_NS is not set
> +# CONFIG_USER_NS is not set
> +# CONFIG_PID_NS is not set
> +# CONFIG_NET_NS is not set
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> +CONFIG_PROFILING=y
> +CONFIG_OPROFILE=y
> +CONFIG_MODULES=y
> +CONFIG_MODULE_UNLOAD=y
> +# CONFIG_LBDAF is not set
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_IOSCHED_DEADLINE is not set
> +# CONFIG_IOSCHED_CFQ is not set
> +CONFIG_ARCH_VEXPRESS=y
> +CONFIG_ARCH_VEXPRESS_CA9X4=y
> +# CONFIG_SWP_EMULATE is not set
> +CONFIG_SMP=y
> +CONFIG_VMSPLIT_2G=y
> +CONFIG_HOTPLUG_CPU=y

This will probably cause a compile-time error with a mainline kernel
because the necessary hotplug functions aren't implemented for vexpress.

Will
