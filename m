From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 12:10:49 -0700
Subject: [PATCH] ARM: Fix XIP build due to PHYS_OFFSET definition moving
In-Reply-To: <5024AE2D.5050506@codeaurora.org>
References: <1343956994-27513-1-git-send-email-sboyd@codeaurora.org>
 <5024AE2D.5050506@codeaurora.org>
Message-ID: <50352EB9.4000402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/12 23:46, Stephen Boyd wrote:
> On 8/2/2012 6:23 PM, Stephen Boyd wrote:
>> During the p2v changes, the PHYS_OFFSET #define moved into a
>> !__ASSEMBLY__ section. This causes a XIP build to fail with
>>
>>  arch/arm/kernel/head.o: In function 'stext':
>>  arch/arm/kernel/head.S:146: undefined reference to 'PHYS_OFFSET'
>>
>> Momentarily leave the #ifndef __ASSEMBLY__ section so we can
>> define PHYS_OFFSET for all compilation units.
>>
>> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
>> ---
>>
>> I don't know if it's worth stable, seems that nobody has compiled XIP for
>> a year (back to 2.6.39 days?).
> Is this approach acceptable? Shall I put this in the patch tracker?
>

I'll take silence to mean "yes", so I'll put this in the patch tracker
unless someone objects.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
