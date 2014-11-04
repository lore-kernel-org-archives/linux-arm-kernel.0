From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 4 Nov 2014 06:24:55 +0000
Subject: [PATCH] arm: imx: clean up machine mxc_arch_reset_init_dt reset
 init
In-Reply-To: <20141104061212.GH10821@tiger>
References: <1414748393-20799-1-git-send-email-jingchang.lu@freescale.com>
 <20141104061212.GH10821@tiger>
Message-ID: <4ac66b526b7241928f7f5b3d6dc45a50@BN3PR0301MB1236.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Tuesday, November 04, 2014 2:12 PM
>To: Lu Jingchang-B35083
>Cc: linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org
>Subject: Re: [PATCH] arm: imx: clean up machine mxc_arch_reset_init_dt
>reset init
>
>On Fri, Oct 31, 2014 at 05:39:53PM +0800, Jingchang Lu wrote:
>> diff --git a/arch/arm/mach-imx/imx31-dt.c
>> b/arch/arm/mach-imx/imx31-dt.c index 418dbc8..e0a4e2f 100644
>> --- a/arch/arm/mach-imx/imx31-dt.c
>> +++ b/arch/arm/mach-imx/imx31-dt.c
>> @@ -15,16 +15,8 @@
>>  #include <asm/mach/arch.h>
>>  #include <asm/mach/time.h>
>>
>> -#include "common.h"
>
>The change causes the build errors below.
>
>  CC      arch/arm/mach-imx/imx31-dt.o
>../arch/arm/mach-imx/imx31-dt.c: In function ?imx31_dt_timer_init?:
>../arch/arm/mach-imx/imx31-dt.c:27:2: error: implicit declaration of
>function ?mx31_clocks_init_dt? [-Werror=implicit-function-declaration]
>../arch/arm/mach-imx/imx31-dt.c: At top level:
>../arch/arm/mach-imx/imx31-dt.c:31:13: error: ?mx31_map_io? undeclared
>here (not in a function)
>../arch/arm/mach-imx/imx31-dt.c:32:16: error: ?imx31_init_early?
>undeclared here (not in a function)
>../arch/arm/mach-imx/imx31-dt.c:33:14: error: ?mx31_init_irq? undeclared
>here (not in a function)
>
>So the common.h inclusion needs to be kept.  I fixed it up and applied the
>patch.
>
>Shawn

Many thanks!

Best Regards,
Jingchang
