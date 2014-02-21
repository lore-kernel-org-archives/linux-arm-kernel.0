From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 20 Feb 2014 22:19:02 -0300
Subject: [PATCH v2 22/23] ARM: config: Add mvebu_v5_defconfig
In-Reply-To: <1392459621-24003-23-git-send-email-andrew@lunn.ch>
References: <1392459621-24003-1-git-send-email-andrew@lunn.ch>
 <1392459621-24003-23-git-send-email-andrew@lunn.ch>
Message-ID: <20140221011901.GA3325@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sat, Feb 15, 2014 at 11:20:20AM +0100, Andrew Lunn wrote:
> Now that there is both v5 and v7 systems in mach-mvebu, the
> mvebu_defconfig is not sufficient, since these systems cannot be
> combined. Add a v5 defconfig which is based on kirkwood_defconfig,
> but purely DT.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/configs/mvebu_v5_defconfig | 166 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 arch/arm/configs/mvebu_v5_defconfig
> 
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> new file mode 100644
> index 000000000000..42e4ec641b4c
> --- /dev/null
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -0,0 +1,166 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_LOG_BUF_SHIFT=19
> +CONFIG_PROFILING=y
> +CONFIG_OPROFILE=y

You're missing CONFIG_ORION_WATCHDOG=y, probably because it doesn't
build in v3.14-rc1 on ARCH_MVEBU.

I think it's safe to add it to the defconfig, so once the watchdog
MVEBU changes are merged, it'll get selected.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
