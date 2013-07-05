From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Jul 2013 23:48:14 +0100
Subject: [PATCH] arm: Convert sa1111 platform and bus legacy pm_ops to
 dev_pm_ops
In-Reply-To: <1373064297-13582-1-git-send-email-shuah.kh@samsung.com>
References: <1373064297-13582-1-git-send-email-shuah.kh@samsung.com>
Message-ID: <20130705224814.GM24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 04:44:57PM -0600, Shuah Khan wrote:
> Convert arch/arm/common/sa1111 platform and bus legacy pm_ops to dev_pm_ops.
> This change also updates the use of COMFIG_PM to CONFIG_PM_SLEEP as this
> platform and bus code implements PM_SLEEP ops and not the PM_RUNTIME ops.
> Compile tested.

Err...

> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 2a64c12..95594f0 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -1321,7 +1321,7 @@ static int sa1111_bus_resume(struct device *dev)
>  }
>  static SIMPLE_DEV_PM_OPS(sa1111_bus_dev_pm_ops, sa1111_bus_suspend,
>  			 sa1111_bus_resume);
> -#endif 
> +#endif

Patch doesn't match description.
