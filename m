From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jan 2017 18:17:28 +0000
Subject: [PATCH 1/2] arm64: kvm: reuse existing cache type/info related
 macros
In-Reply-To: <1484909410-11673-1-git-send-email-sudeep.holla@arm.com>
References: <1484909410-11673-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170123181727.GJ28914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 10:50:09AM +0000, Sudeep Holla wrote:
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
>  arch/arm64/include/asm/cachetype.h |  7 +++++++
>  arch/arm64/kernel/cacheinfo.c      |  7 -------
>  arch/arm64/kvm/sys_regs.c          | 27 +++++++++++++--------------
>  3 files changed, 20 insertions(+), 21 deletions(-)

I assume both of these will go via kvm-arm.

Will
