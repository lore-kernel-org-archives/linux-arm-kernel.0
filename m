From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 25 Sep 2015 14:05:52 +0100
Subject: [PATCH 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <20150925113808.GL6281@e103592.cambridge.arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
 <1442413280-31885-8-git-send-email-suzuki.poulose@arm.com>
 <20150925113808.GL6281@e103592.cambridge.arm.com>
Message-ID: <560546B0.7070909@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/09/15 12:38, Dave P Martin wrote:
> On Wed, Sep 16, 2015 at 03:21:05PM +0100, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> This patch adds an infrastructure to keep track of the CPU feature
>> registers on the system. For each register, the infrastructure keeps
>> track of the system wide safe value of the feature bits. Also, tracks
>> the which fields of a register should be matched strictly across all
>> the CPUs on the system for the SANITY check infrastructure.
>>
>> The feature bits are classified as one of SCALAR_MIN, SCALAR_MAX and DISCRETE
>> depending on the implication of the possible values. This information
>> is used to decide the safe value for a feature.
>>
>> SCALAR_MIN - The smaller value is safer
>> SCALAR_MAX - The bigger value is safer
>> DISCRETE - We can't decide between the two, so a predefined safe_value is used.
>
> Can documentation of the meanings of these be added somewhere in the
> relevant header or in Documentation?

Sure. They were part of the initial draft and eventually lost them over the
reworks. I will add them back, since there is wider use of the information
across the system, from what I started with(i.e, Userspace visibility).

Cheers
Suzuki
