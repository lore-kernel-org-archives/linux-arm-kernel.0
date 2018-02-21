From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:43:49 +0100
Subject: [PATCH v4 16/40] KVM: arm64: Remove noop calls to timer
 save/restore from VHE switch
In-Reply-To: <20180215210332.8648-17-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-17-christoffer.dall@linaro.org>
Message-ID: <20180221174349.3e7kpo475k3pi6rv@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:08PM +0100, Christoffer Dall wrote:
> The VHE switch function calls __timer_enable_traps and
> __timer_disable_traps which don't do anything on VHE systems.
> Therefore, simply remove these calls from the VHE switch function and
> make the functions non-conditional as they are now only called from the
> non-VHE switch path.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v2:
>      - Added comment explaining the timer enable/disable functions
>        are for !VHE only.
> 
>  arch/arm64/kvm/hyp/switch.c |  2 --
>  virt/kvm/arm/hyp/timer-sr.c | 44 ++++++++++++++++++++++----------------------
>  2 files changed, 22 insertions(+), 24 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
