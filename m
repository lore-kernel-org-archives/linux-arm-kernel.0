From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 11 Nov 2016 21:46:29 +0800
Subject: [PATCH v14 4/9] acpi/arm64: Add GTDT table parse driver
In-Reply-To: <20161020163719.GC27598@leverpostej>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-5-git-send-email-fu.wei@linaro.org>
 <20161020163719.GC27598@leverpostej>
Message-ID: <5825CBB5.8090104@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Sorry for the late reply.

On 10/21/2016 12:37 AM, Mark Rutland wrote:
> Hi,
>
> As a heads-up, on v4.9-rc1 I see conflicts at least against
> arch/arm64/Kconfig. Luckily git am -3 seems to be able to fix that up
> automatically, but this will need to be rebased before the next posting
> and/or merging.
>
> On Thu, Sep 29, 2016 at 02:17:12AM +0800, fu.wei at linaro.org wrote:
>> +static int __init map_gt_gsi(u32 interrupt, u32 flags)
>> +{
>> +	int trigger, polarity;
>> +
>> +	if (!interrupt)
>> +		return 0;
>
> Urgh.
>
> Only the secure interrupt (which we do not need) is optional in this
> manner, and (hilariously), zero appears to also be a valid GSIV, per
> figure 5-24 in the ACPI 6.1 spec.
>
> So, I think that:
>
> (a) we should not bother parsing the secure interrupt
> (b) we should drop the check above
> (c) we should report the spec issue to the ASWG

Sorry, I willing to do that, but I need to figure out the issue here.
What kind of issue in detail? do you mean that zero should not be valid
for arch timer interrupts?

Thanks
Hanjun
