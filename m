From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 30 Dec 2014 12:15:14 +0000
Subject: [PATCH] arm64: Fix SCTLR_EL1 initialisation
In-Reply-To: <20141217173915.GF30307@arm.com>
References: <1418831421-19370-1-git-send-email-suzuki.poulose@arm.com>
 <20141217173915.GF30307@arm.com>
Message-ID: <54A29752.2060204@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/14 17:39, Will Deacon wrote:
> On Wed, Dec 17, 2014 at 03:50:21PM +0000, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> We initialise the SCTLR_EL1 value by read-modify-writeback
>> of the desired bits, leaving the other bits (including reserved
>> bits(RESx)) untouched. However, sometimes the boot monitor could
>> leave garbage values in the RESx bits which could have different
>> implications. This patch makes sure that all the bits, including
>> the RESx bits, are set to the proper state, except for the
>> 'endianness' control bits, EE(25) & E0E(24)- which are set early
>> in the el2_setup.
>>
>> Updated the state of the Bit[6] in the comment to RES0 in the
>> comment.
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>
> Looks good to me:
>
>    Acked-by: Will Deacon <will.deacon@arm.com>
>
> Is this 3.19 material, or simply a cleanup/being cautious?
Sorry, for the late response. Yes this is kind of being cautious.

Suzuki
