From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Jul 2015 18:18:28 +0100
Subject: [PATCH 01/18] ARM64: Move PMU register related defines to
 asm/pmu.h
In-Reply-To: <1436149068-3784-2-git-send-email-shannon.zhao@linaro.org>
References: <1436149068-3784-1-git-send-email-shannon.zhao@linaro.org>
 <1436149068-3784-2-git-send-email-shannon.zhao@linaro.org>
Message-ID: <20150708171828.GD6348@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 03:17:31AM +0100, shannon.zhao at linaro.org wrote:
> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> To use the ARMv8 PMU related register defines from the KVM code,
> we move the relevant definitions to asm/pmu.h header file.
> 
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> ---
>  arch/arm64/include/asm/pmu.h   | 45 ++++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/perf_event.c | 35 --------------------------------
>  2 files changed, 45 insertions(+), 35 deletions(-)

Whilst I'm ok with the idea, we're currently in the process of moving the
ARM and arm64 PMU drivers out into drivers/perf/, so this is likely to
conflict horribly with that work.

Christoffer/Marc: if you end up wanting to queue this for 4.3, give me a
shout and I'll try to create a stable branch you can use as a base (but
it's likely to contain a whole heap of stuff you don't want...).

Will
