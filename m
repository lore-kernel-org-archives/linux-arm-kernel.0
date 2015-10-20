From: james.morse@arm.com (James Morse)
Date: Tue, 20 Oct 2015 17:22:04 +0100
Subject: [PATCH 2/2] fixup! arm64: kvm: allows kvm cpu hotplug
In-Reply-To: <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
References: <1445327907-23274-1-git-send-email-takahiro.akashi@linaro.org>
 <1445327907-23274-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <56266A2C.7000005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/15 08:58, AKASHI Takahiro wrote:
> Without this patch, kvm cannot start a guest when cpuidle is enabled
> if the hardware does not retain cpu state (EL2) in idle state.
> 
> This patch re-initailizes EL2 state at CPU_PM_EXIT by calling
> kvm_arch_hardware_enable() if and only if kvm has been initialized
> before CPU_PM_ENTER, that is, if any vcpus have been created.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This solves my issue with the v5 version here [0].
Tested-By: James Morse <james.morse@arm.com>


Thanks!

James

[0] https://lists.linaro.org/pipermail/linaro-kernel/2015-May/021575.html
