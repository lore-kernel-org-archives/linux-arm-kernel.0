From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Thu, 28 Jan 2016 11:27:17 +0000
Subject: [PATCH] arm64: Disallow combination of ARCH_XGENE and 16K page
 size
In-Reply-To: <20160128110820.GE30928@arm.com>
References: <1453936230-7305-1-git-send-email-dann.frazier@canonical.com>
 <20160128103441.GS14823@e104818-lin.cambridge.arm.com>
 <20160128110820.GE30928@arm.com>
Message-ID: <56A9FB15.1080203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/16 11:08, Will Deacon wrote:
> On Thu, Jan 28, 2016 at 10:34:41AM +0000, Catalin Marinas wrote:
>> On Wed, Jan 27, 2016 at 04:10:30PM -0700, dann frazier wrote:
>>> 16K page size is an optional feature of the architecture, and is not
>>> supported by the X-Gene SoC family.

   This enables support for AppliedMicro X-Gene SOC Family
>>
>> This would be the case on Juno as well. But maybe at some point the
>> X-Gene family would gain a CPU with such support.
>>
>> Anyway, I would rather make 16K pages depend on EXPERT, make it a bit
>> harder to enable. We've had a few questions recently about enabling it
>> on CPUs that don't have such feature.
>
> I thought there was also a suggestion that we could fail gracefully in
> the EFI stub if we detected an unsupported page size?

Yes, there was. But then it was also recommended [1] to add a new stubbed function
for both arm & arm64, where it got lost. May be we should revive it.

https://lkml.org/lkml/2015/10/15/489


Thanks
Suzuki
