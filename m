From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Mar 2014 12:01:45 +0000
Subject: [PATCH v2 2/3] arm64: defconfig: Enable ARCH_GH7 by default
In-Reply-To: <1394491879-5320-3-git-send-email-kgene.kim@samsung.com>
References: <1394491879-5320-1-git-send-email-kgene.kim@samsung.com>
 <1394491879-5320-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <20140311120145.GE31104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 10, 2014 at 10:51:18PM +0000, Kukjin Kim wrote:
> This patch adds support for Samsung GH7 SoC in arm64/Kconfig and
> enable Samsung GH7 based SSDK_GH7 in single defconfig for arm64.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/Kconfig           | 3 +++
>  arch/arm64/boot/dts/Makefile | 1 +
>  arch/arm64/configs/defconfig | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index dd4327f..f0f2bf2 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -111,6 +111,9 @@ source "kernel/Kconfig.freezer"
>  
>  menu "Platform selection"
>  
> +config ARCH_GH7
> +	bool

You should add some text here so that people can disable it. The aim is
single Image by default but I think we should let people disable certain
platforms for more targeted deployments.

-- 
Catalin
