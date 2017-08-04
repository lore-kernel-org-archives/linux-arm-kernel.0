From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 4 Aug 2017 14:18:01 +0100
Subject: [PATCH][RESEND] arm64: kvm: reuse existing cache type/info
 related macros
In-Reply-To: <20170804130854.GB27784@cbox>
References: <1501851237-13017-1-git-send-email-sudeep.holla@arm.com>
 <20170804130854.GB27784@cbox>
Message-ID: <5267f4a8-7c0d-a37f-5823-ce3385b629b8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 04/08/17 14:08, Christoffer Dall wrote:
> Hi Sudeep,
> 
> On Fri, Aug 04, 2017 at 01:53:57PM +0100, Sudeep Holla wrote:
>> We already have various macros related to cache type and bitfields in
>> CLIDR system register. We can replace some of the hardcoded values
>> here using those existing macros.
>>
>> This patch reuses those existing cache type/info related macros and
>> replaces the hardcorded values. It also removes some of the comments
>> that become trivial with the macro names.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  arch/arm64/include/asm/cache.h |  7 +++++++
>>  arch/arm64/kernel/cacheinfo.c  |  7 -------
>>  arch/arm64/kvm/sys_regs.c      | 29 +++++++++++++++--------------
>>  3 files changed, 22 insertions(+), 21 deletions(-)
>>
>> Hi,
>>
>> I dropped the support for 64bit format CCSIDR after Will's commit a8d4636f96ad
>> ("arm64: cacheinfo: Remove CCSIDR-based cache information probing"). However
>> I forgot to follow up on this patch which can be still applied. So just
>> reposting again rebasing on v4.13-rc3 as mentioned by Will as it was too
>> late for last cycle. Christoffer was fine with the changes but has not
>> given an official ACK.
>>
> 
> Reviewed-by: Christoffer Dall <cdall@linaro.org>
> 
Thanks for the quick response and review tag.

-- 
Regards,
Sudeep
