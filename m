From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Apr 2016 17:47:27 +0100
Subject: [PATCH v3 3/7] arm64: Add helpers for detecting AArch32 support
 at EL0
In-Reply-To: <570FC950.1070904@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
 <1459445255-15653-4-git-send-email-suzuki.poulose@arm.com>
 <20160414163933.GG4584@arm.com> <570FC950.1070904@arm.com>
Message-ID: <20160414164727.GK4584@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 05:46:08PM +0100, Suzuki K Poulose wrote:
> On 14/04/16 17:39, Will Deacon wrote:
> >On Thu, Mar 31, 2016 at 06:27:31PM +0100, Suzuki K Poulose wrote:
> >>Adds a helper to extract the support for AArch32 at EL0
> >>
> >>Tested-by: Yury Norov <ynorov@caviumnetworks.com>
> >>Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> >>+static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
> >>+{
> >>+	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL0_SHIFT);
> >>+
> >>+	return val == ID_AA64PFR0_EL0_32BIT_64BIT;
> >
> >Should this be >=? What are the rules for this register?
> 
> This feature value is kind of "FTR_EXACT" where, we don't know what the relationship
> of the values are. Here is the list of possible values :
> 
> 0001	EL0 can be executed in AArch64 state only.
> 0010	EL0 can be executed in either AArch64 or AArch32 state.
> 
> All the other values are reserved. So I believe "==" is better check.

Yeah, and thinking about it some more, that makes sense. Thanks.

Will
