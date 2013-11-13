From: acourbot@nvidia.com (Alex Courbot)
Date: Wed, 13 Nov 2013 10:59:56 +0900
Subject: [PATCH v10 4/7] ARM: tegra: add support for Trusted Foundations
In-Reply-To: <52828E31.8010408@wwwdotorg.org>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
 <1383819106-1400-5-git-send-email-acourbot@nvidia.com>
 <52828E31.8010408@wwwdotorg.org>
Message-ID: <5282DD1C.4000307@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2013 05:23 AM, Stephen Warren wrote:
> On 11/07/2013 03:11 AM, Alexandre Courbot wrote:
>> Register the firmware operations for Trusted Foundations if the device
>> tree indicates it is active on the device.
>
>> diff --git a/arch/arm/mach-tegra/common.c b/arch/arm/mach-tegra/common.c
>
>>   void __init tegra_init_early(void)
>>   {
>> +	of_register_trusted_foundations();
>>   	tegra_cpu_reset_handler_init();
>>   	tegra_apb_io_init();
>>   	tegra_init_fuse();
>
> Your other bugfix patch for 3.13 moved tegra_cpu_reset_handler_init().
> Should the call to of_register_trusted_foundations() move with it when
> this is applied, or should it just stay right at the start of
> tegra_init_early()? Either way is fine; just let me know which way to
> fix up the conflict when this gets applied.

I rebased on -next and left it at the start of tegra_init_early(). Even 
though at the moment the only requirement is that the call is made 
before tegra_cpu_reset_handler_init(), it seems to make sense to get rid 
of firmware-related initialization as early as possible.

Btw, this patchset is still based on the 3.12 code, before common.c got 
renamed to tegra.c, so you will have a problem here as well (sorry about 
that). The conflict is easy to resolve, but if you want me to send you a 
properly rebased version, just let me know.
