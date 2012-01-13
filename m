From: rmallon@gmail.com (Ryan Mallon)
Date: Sat, 14 Jan 2012 08:35:01 +1100
Subject: [PATCH 01/11] ep93xx: Move PHYS_BASE defines to local SoC header
 file
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F001F3F99EBAE8@AUSP01VMBX24.collaborationhost.net>
References: <1326251676-7593-1-git-send-email-rmallon@gmail.com>
 <1326251676-7593-2-git-send-email-rmallon@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F001F3F99EBAE8@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4F10A385.7080007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/01/12 04:18, H Hartley Sweeten wrote:
> On Tuesday, January 10, 2012 8:14 PM, Ryan Mallon wrote:
>> The PHYS_BASE defines in arch/arm/mach-ep93xx/include/mach-ep93xx-regs.h
>> are only used in the SoC code. Move the defines to a local header file.
>>
>> Cc: Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Mika Westerberg <mika.westerberg@iki.fi>
>> Signed-off-by: Ryan Mallon <rmallon@gmail.com>
>> ---
>>  arch/arm/mach-ep93xx/adssphere.c                |    1 +
>>  arch/arm/mach-ep93xx/edb93xx.c                  |    2 +
>>  arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
>>  arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |   34 ---------------
>>  arch/arm/mach-ep93xx/micro9.c                   |    1 +
>>  arch/arm/mach-ep93xx/simone.c                   |    2 +
>>  arch/arm/mach-ep93xx/snappercl15.c              |    2 +
>>  arch/arm/mach-ep93xx/soc.h                      |   50 +++++++++++++++++++++++
>>  arch/arm/mach-ep93xx/ts72xx.c                   |    2 +
>>  arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
>>  10 files changed, 63 insertions(+), 34 deletions(-)  create mode 100644 arch/arm/mach-ep93xx/soc.h
> <snip>
>
>> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c index 70ef8c5..24df3ff 100644
>> --- a/arch/arm/mach-ep93xx/edb93xx.c
>> +++ b/arch/arm/mach-ep93xx/edb93xx.c
>> @@ -42,6 +42,8 @@
>>  #include <asm/mach-types.h>
>>  #include <asm/mach/arch.h>
>>  
>> +#include "soc.h"
>> +
>  
> Nitpick... Unnecessary whitespace...
>
> <snip>
>
>> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c index 8b2f143..f5965db 100644
>> --- a/arch/arm/mach-ep93xx/ts72xx.c
>> +++ b/arch/arm/mach-ep93xx/ts72xx.c
>> @@ -27,6 +27,8 @@
>>  #include <asm/mach/map.h>
>>  #include <asm/mach/arch.h>
>>  
>> +#include "soc.h"
>> +
> Nitpick... Unnecessary whitespace...

Oops, will fix.

>  
> Other than that... Looks ok.
>
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>
Thanks,
~Ryan
