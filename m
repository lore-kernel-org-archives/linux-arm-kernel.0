From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 Aug 2014 15:21:06 +0100
Subject: [PATCH v7 4/8] arm64: kernel: introduce cpu_init_idle CPU
 operation
In-Reply-To: <1407945127-27554-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-5-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20140818142106.GE20043@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 04:52:03PM +0100, Lorenzo Pieralisi wrote:
> The CPUidle subsystem on ARM64 machines requires the idle states
> implementation back-end to initialize idle states parameter upon
> boot. This patch adds a hook in the CPU operations structure that
> should be initialized by the CPU operations back-end in order to
> provide a function that initializes cpu idle states.
> 
> This patch also adds the infrastructure to arm64 kernel required
> to export the CPU operations based initialization interface, so
> that drivers (ie CPUidle) can use it when they are initialized
> at probe time.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/cpu_ops.h |  3 +++
>  arch/arm64/include/asm/cpuidle.h | 13 +++++++++++++
>  arch/arm64/kernel/Makefile       |  1 +
>  arch/arm64/kernel/cpuidle.c      | 29 +++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 arch/arm64/include/asm/cpuidle.h
>  create mode 100644 arch/arm64/kernel/cpuidle.c

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
