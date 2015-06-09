From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 09 Jun 2015 19:00:00 +0100
Subject: [PATCH v5 1/2] arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
References: <1432877920-12527-1-git-send-email-takahiro.akashi@linaro.org>
 <1432877920-12527-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <557729A0.1030700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,

On 29/05/15 06:38, AKASHI Takahiro wrote:
> The current kvm implementation on arm64 does cpu-specific initialization
> at system boot, and has no way to gracefully shutdown a core in terms of
> kvm. This prevents, especially, kexec from rebooting the system on a boot
> core in EL2.
> 
> This patch adds a cpu tear-down function and also puts an existing cpu-init
> code into a separate function, kvm_arch_hardware_disable() and
> kvm_arch_hardware_enable() respectively.
> We don't need arm64-specific cpu hotplug hook any more.
> 
> Since this patch modifies common part of code between arm and arm64, one
> stub definition, __cpu_reset_hyp_mode(), is added on arm side to avoid
> compiling errors.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This is starting to look good. Any chance you or Geoff could repost the
whole series? This would help getting a better view of the whole thing,
and hopefully put it on track for 4.3.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
