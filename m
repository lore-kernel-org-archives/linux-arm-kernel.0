From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 4 Aug 2017 14:17:50 +0100
Subject: [PATCH][RESEND] arm64: kvm: reuse existing cache type/info
 related macros
In-Reply-To: <1501851237-13017-1-git-send-email-sudeep.holla@arm.com>
References: <1501851237-13017-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <17464d78-829a-49d6-5ace-8c316e9baa0c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/17 13:53, Sudeep Holla wrote:
> We already have various macros related to cache type and bitfields in
> CLIDR system register. We can replace some of the hardcoded values
> here using those existing macros.
> 
> This patch reuses those existing cache type/info related macros and
> replaces the hardcorded values. It also removes some of the comments
> that become trivial with the macro names.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/include/asm/cache.h |  7 +++++++
>  arch/arm64/kernel/cacheinfo.c  |  7 -------
>  arch/arm64/kvm/sys_regs.c      | 29 +++++++++++++++--------------
>  3 files changed, 22 insertions(+), 21 deletions(-)
> 
> Hi,
> 
> I dropped the support for 64bit format CCSIDR after Will's commit a8d4636f96ad
> ("arm64: cacheinfo: Remove CCSIDR-based cache information probing"). However
> I forgot to follow up on this patch which can be still applied. So just
> reposting again rebasing on v4.13-rc3 as mentioned by Will as it was too
> late for last cycle. Christoffer was fine with the changes but has not
> given an official ACK.

Hi Sudeep,

I've queued it for the next cycles.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
