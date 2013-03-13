From: sameo@linux.intel.com (Samuel Ortiz)
Date: Wed, 13 Mar 2013 09:39:23 +0100
Subject: [PATCH v2] mfd: ab8500-gpadc: Complain if we fail to enable
 vtvout LDO
In-Reply-To: <1362822405.8907.1.camel@phoenix>
References: <1362822405.8907.1.camel@phoenix>
Message-ID: <20130313083923.GI21994@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Axel,

On Sat, Mar 09, 2013 at 05:46:45PM +0800, Axel Lin wrote:
> Since commit c8801a8e
> "regulator: core: Mark all get and enable calls as __must_check",
> we must check return value of regulator_enable() to silence below build warning.
> 
>   CC      drivers/mfd/ab8500-gpadc.o
> drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_runtime_resume':
> drivers/mfd/ab8500-gpadc.c:598:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
> drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_probe':
> drivers/mfd/ab8500-gpadc.c:655:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
> 
> Also convert to devm_regulator_get(), this fixes a missing regulator_put() call
> in ab8500_gpadc_remove().
This is on the edge of a patch split for 2 separate fixes, but I applied it
anyway.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
