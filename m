From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 12:08:15 +0000
Subject: [PATCH 8/9] KVM: arm/arm64: vgic: Don't check vgic_initialized in
 flush_hwstate
In-Reply-To: <20170320105818.20481-9-cdall@linaro.org>
References: <20170320105818.20481-1-cdall@linaro.org>
 <20170320105818.20481-9-cdall@linaro.org>
Message-ID: <96b0efe2-d764-7b52-8335-0383a9357a1f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 10:58, Christoffer Dall wrote:
> Now when we do an early init of the static parts of the VGIC data
> structures, we can do things like checking if the AP lists are empty
> directly without having to explicitly check if the vgic is initialized
> and reduce a bit of work in our criticial path.

                                  critical

> Note: list_empty is a single atomic read (uses READ_ONCE) and can
> therefore check if a list is empty or not without the need to take the
> spinlock protecting the list.

This note might be better placed in patch #2.

> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
