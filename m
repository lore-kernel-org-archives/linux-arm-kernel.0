From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Wed, 24 Nov 2010 19:11:54 +0300
Subject: [PATCH v2 1/3] ARM: cns3xxx: Add new and export the old power
	management functions
In-Reply-To: <1290443565-20766-2-git-send-email-mkl0301@gmail.com>
References: <1290443565-20766-1-git-send-email-mkl0301@gmail.com>
	<1290443565-20766-2-git-send-email-mkl0301@gmail.com>
Message-ID: <20101124161154.GA10890@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 23, 2010 at 12:32:43AM +0800, mkl0301 at gmail.com wrote:
> From: Mac Lin <mkl0301@gmail.com>
> 
> This patch add cns3xxx_pwr_clk_dis, and export thoes power management functions
> that may be used by many other device drivers on CNS3XXX.
> 
> Signed-off-by: Mac Lin <mkl0301@gmail.com>
> ---
>  arch/arm/mach-cns3xxx/core.h            |    4 ++--
>  arch/arm/mach-cns3xxx/include/mach/pm.h |   19 +++++++++++++++++++
>  arch/arm/mach-cns3xxx/pm.c              |   17 +++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-cns3xxx/include/mach/pm.h
> 
> diff --git a/arch/arm/mach-cns3xxx/core.h b/arch/arm/mach-cns3xxx/core.h
> index 6b33ec1..c6636bd 100644
> --- a/arch/arm/mach-cns3xxx/core.h
> +++ b/arch/arm/mach-cns3xxx/core.h
> @@ -11,13 +11,13 @@
>  #ifndef __CNS3XXX_CORE_H
>  #define __CNS3XXX_CORE_H
>  
> +#include <mach/pm.h>

This isn't needed in this file. Instead, devices.c should include
it. Plus, pm.c needs to include mach/pm.h, otherwise sparse gives
the following warnings:

  CHECK   arch/arm/mach-cns3xxx/pm.c
pm.c:26:6: warning: symbol 'cns3xxx_pwr_clk_dis' was not declared. Should it be static?
pm.c:35:6: warning: symbol 'cns3xxx_pwr_power_up' was not declared. Should it be static?
pm.c:47:6: warning: symbol 'cns3xxx_pwr_power_down' was not declared. Should it be static?
pm.c:121:10: warning: symbol 'usb_pwr_ref' was not declared. Should it be static?

I've fixed it up, and applied the patch to cns3xxx tree.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
