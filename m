From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 23 Nov 2016 14:55:09 +0000
Subject: [PATCH] arm64: defconfig: Do not lower CONFIG_LOG_BUF_SHIFT
In-Reply-To: <1479908176-13625-1-git-send-email-geert+renesas@glider.be>
References: <1479908176-13625-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161123145508.GK28723@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2016 at 02:36:16PM +0100, Geert Uytterhoeven wrote:
> The default value of 17 for CONFIG_LOG_BUF_SHIFT is much more suitable
> than 14. The latter easily leads to lost kernel messages on systems with
> only one CPU core.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/configs/defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0e41290f6cbb4101..f284568373adf917 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -11,7 +11,6 @@ CONFIG_TASK_XACCT=y
>  CONFIG_TASK_IO_ACCOUNTING=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
> -CONFIG_LOG_BUF_SHIFT=14
>  CONFIG_MEMCG=y
>  CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y

The defconfig updates usually go via arm-soc. The patch looks fine to
me:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
