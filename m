From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Oct 2018 09:03:30 +0100
Subject: [PATCH] mfd: db8500-prcmu: Fix some section annotations
In-Reply-To: <20181018005628.8295-1-natechancellor@gmail.com>
References: <20181018005628.8295-1-natechancellor@gmail.com>
Message-ID: <20181025080330.GI4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2018, Nathan Chancellor wrote:

> When building the kernel with Clang, the following section mismatch
> warnings appear:
> 
> WARNING: vmlinux.o(.text+0x7239cc): Section mismatch in reference from
> the function db8500_prcmu_probe() to the function
> .init.text:init_prcm_registers()
> The function db8500_prcmu_probe() references
> the function __init init_prcm_registers().
> This is often because db8500_prcmu_probe lacks a __init
> annotation or the annotation of init_prcm_registers is wrong.
> 
> WARNING: vmlinux.o(.text+0x723e28): Section mismatch in reference from
> the function db8500_prcmu_probe() to the function
> .init.text:fw_project_name()
> The function db8500_prcmu_probe() references
> the function __init fw_project_name().
> This is often because db8500_prcmu_probe lacks a __init
> annotation or the annotation of fw_project_name is wrong.
> 
> db8500_prcmu_probe should not be marked as __init so remove the __init
> annotation from fw_project_name and init_prcm_registers.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/mfd/db8500-prcmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied for v4.21, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
