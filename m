From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 10:56:32 -0600
Subject: [PATCH] ARM: tegra: Include assembler.h in sleep.S to fix build
 break
In-Reply-To: <4F6764B6.6050109@gmail.com>
References: <1332175831-5900-1-git-send-email-swarren@wwwdotorg.org>
 <4F6764B6.6050109@gmail.com>
Message-ID: <4F676540.8060903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2012 10:54 AM, Rob Herring wrote:
> On 03/19/2012 11:50 AM, Stephen Warren wrote:
>> Commit 6f6f6a7 "ARM: create a common IOMEM definition" moved macro
>> IOMEM(), and requires users to include <asm/assembler.h>. Fix Tegra's
>> sleep.S to do so.
>>
>> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
>> ---
>>  arch/arm/mach-tegra/sleep.S |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
...
>> +#include <asm/assembler.h>
>> +
> 
> Is there some reason you put this before linux/ include?

No. I just misremembered which order linux/ and asm/ should go in. Do
you want me to repost?

>>  #include <linux/linkage.h>
>> +
>>  #include <mach/io.h>
>>  #include <mach/iomap.h>
