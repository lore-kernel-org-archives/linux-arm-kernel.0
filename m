From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Sep 2014 15:25:44 -0700
Subject: [PATCH v4 10/11] ARM: kernel: add support for cpu cache
 information
In-Reply-To: <1409763617-17074-11-git-send-email-sudeep.holla@arm.com>
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-11-git-send-email-sudeep.holla@arm.com>
Message-ID: <541CAD68.2090009@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/14 10:00, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> This patch adds support for cacheinfo on ARM platforms.
>
> On ARMv7, the cache hierarchy can be identified through Cache Level ID
> register(CLIDR) while the cache geometry is provided by Cache Size ID
> register(CCSIDR).
>
> On architecture versions before ARMv7, CLIDR and CCSIDR is not
> implemented. The cache type register(CTR) provides both cache hierarchy
> and geometry if implemented. For implementations that doesn't support
> CTR, we need to list the probable value of CTR if it was implemented
> along with the cpuid for the sake of simplicity to handle them.
>
> Since the architecture doesn't provide any way of detecting the cpus
> sharing particular cache, device tree is used fo the same purpose.
> On non-DT platforms, first level caches are per-cpu while higher level
> caches are assumed system-wide.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
>

Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
