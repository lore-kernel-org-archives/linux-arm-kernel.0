From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 14 Sep 2010 14:37:25 +0800
Subject: [PATCH 1/1] ARM: pxa: fix NFS build issue
In-Reply-To: <1284445197-17403-1-git-send-email-haojian.zhuang@marvell.com>
References: <1284445197-17403-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <AANLkTinmrATdicROXh7C_c-eH1Pr-r0cGCUfC8WR8ri4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 14, 2010 at 2:19 PM, Haojian Zhuang
<haojian.zhuang@marvell.com> wrote:
> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_lzo.c:(.text+0x81380): undefined reference to `svc_gss_principal'
> make: *** [.tmp_vmlinux1] Error 1
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Cannot remember the exact link, but this should have been solved by
adding the correct constraint to the Kconfig.

Uwe, do you have the link and what's the status of that patch being upstreamed?

> Cc: Eric Miao <eric.y.miao@gmail.com>
> Cc: Vincent Sanders <vince@simtec.co.uk>
> ---
> ?arch/arm/configs/pxa3xx_defconfig | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
> index 1677a06..6d30baf 100644
> --- a/arch/arm/configs/pxa3xx_defconfig
> +++ b/arch/arm/configs/pxa3xx_defconfig
> @@ -118,6 +118,10 @@ CONFIG_NFS_V3=y
> ?CONFIG_NFS_V3_ACL=y
> ?CONFIG_NFS_V4=y
> ?CONFIG_ROOT_NFS=y
> +CONFIG_SUNRPC=y
> +CONFIG_SUNRPC_GSS=y
> +CONFIG_RPCSEC_GSS_KRB5=y
> +CONFIG_RPCSEC_GSS_SPKM3=y
> ?CONFIG_NLS=y
> ?CONFIG_PRINTK_TIME=y
> ?CONFIG_MAGIC_SYSRQ=y
> --
> 1.5.6.5
>
>
