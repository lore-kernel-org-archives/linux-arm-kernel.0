From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 7 Jan 2016 13:28:27 +0000
Subject: [PATCH v8 17/20] KVM: ARM64: Add PMU overflow interrupt routing
In-Reply-To: <1450771695-11948-18-git-send-email-zhaoshenglong@huawei.com>
References: <1450771695-11948-1-git-send-email-zhaoshenglong@huawei.com>
 <1450771695-11948-18-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <20160107132827.402b11f0@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 22 Dec 2015 16:08:12 +0800
Shannon Zhao <zhaoshenglong@huawei.com> wrote:

> From: Shannon Zhao <shannon.zhao@linaro.org>
> 
> When calling perf_event_create_kernel_counter to create perf_event,
> assign a overflow handler. Then when the perf event overflows, set the
> corresponding bit of guest PMOVSSET register. If this counter is enabled
> and its interrupt is enabled as well, kick the vcpu to sync the
> interrupt.
> 
> On VM entry, if there is counter overflowed, inject the interrupt with
> the level set to 1. Otherwise, inject the interrupt with the level set
> to 0.
> 
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
