From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:13 +0100
Subject: [PATCH v7 5/8] arm64: add PSCI CPU_SUSPEND based cpu_suspend
 support
In-Reply-To: <1407945127-27554-6-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-6-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142113.GF20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:04PM +0100, Lorenzo Pieralisi wrote:
> This patch implements the cpu_suspend cpu operations method through
> the PSCI CPU SUSPEND API. The PSCI implementation translates the idle state
> index passed by the cpu_suspend core call into a valid PSCI state according to
> the PSCI states initialized at boot through the cpu_init_idle() CPU
> operations hook.
> 
> The PSCI CPU suspend operation hook checks if the PSCI state is a
> standby state. If it is, it calls the PSCI suspend implementation
> straight away, without saving any context. If the state is a power
> down state the kernel calls the __cpu_suspend API (that saves the CPU
> context) and passed the PSCI suspend finisher as a parameter so that PSCI
> can be called by the __cpu_suspend implementation after saving and flushing
> the context as last function before power down.
> 
> For power down states, entry point is set to cpu_resume physical address,
> that represents the default kernel execution address following a CPU reset.
> 
> Reviewed-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/kernel/psci.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
