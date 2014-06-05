From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 05 Jun 2014 12:11:21 +0800
Subject: [PATCH 1/7] ACPICA: Only include ACPI asm files if ACPI is enabled
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E880262042C@SHSMSX101.ccr.corp.intel.com>
References: <1401883796-17841-1-git-send-email-lee.jones@linaro.org>
 <1401883796-17841-2-git-send-email-lee.jones@linaro.org>
 <3061297.feg5DGUjIt@vostro.rjw.lan> <20140604125137.GA18171@lee--X1>
 <1AE640813FDE7649BE1B193DEA596E880262042C@SHSMSX101.ccr.corp.intel.com>
Message-ID: <538FEDE9.4010603@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-6-5 9:14, Zheng, Lv wrote:
> Hi, Lee
> 
>> From: Lee Jones [mailto:lee.jones at linaro.org]
>> Sent: Wednesday, June 04, 2014 8:52 PM
>> To: Rafael J. Wysocki
>>
>> On Wed, 04 Jun 2014, Rafael J. Wysocki wrote:
>>
>>> On Wednesday, June 04, 2014 01:09:50 PM Lee Jones wrote:
>>>> Any drivers which support ACPI and Device Tree probing need to include
>>>> both respective header files.  Without this patch, if a driver is being
>>>> used on a platform which does not support ACPI and subsequently does not
>>>> have the config option enabled, but includes linux/acpi.h the build
>>>> breaks with:
>>>>
>>>>   In file included from ../include/acpi/platform/acenv.h:150:0,
>>>>                    from ../include/acpi/acpi.h:56,
>>>>                    from ../include/linux/match.h:2,
>>>>                    from ../drivers/i2c/i2c-core.c:43:
>>>>   ../include/acpi/platform/aclinux.h:73:23:
>>>>    fatal error: asm/acenv.h: No such file or directory
>>>>    #include <asm/acenv.h>
>>>>                        ^
> 
> Note that:
> In our tree:
> <asm/acenv.h> is only included by <acpi/acpi.h>.
> And <acpi/acpi.h> is only included by
> 1. <linux/acpi.h> when CONFIG_ACPI enabled
> 2. <linux/sfi_acpi.h> - this is x86 specific, we'll clean it up by implementing stubs for all ACPI external interfaces.
> So there is no case we need to exclude <asm/acenv.h> when CONFIG_ACPI is not enabled.
> 
> I cannot find linux/match.h here.
> If <linux/match.h> want to include ACPI features, it shouldn't include <acpi/acpi.h>, but should include <linux/acpi.h>.
> Please refer to:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8b48463f
> And stop including <acpi/acpi.h> directly in any cases.

Ah, I agree, please ignore my previous email,
sorry for the noise.

Since it is very important to include <linux/acpi.h> but not <acpi/acpi.h>,
can we document it somewhere as the guidance? Then people will not
make such mistake :)

Thanks
Hanjun
