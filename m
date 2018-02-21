From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:41:11 +0100
Subject: [PATCH v4 12/40] KVM: arm64: Factor out fault info population
 and gic workarounds
In-Reply-To: <20180215210332.8648-13-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-13-christoffer.dall@linaro.org>
Message-ID: <20180221174111.hrjmal6lofmvqqoj@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:04PM +0100, Christoffer Dall wrote:
> The current world-switch function has functionality to detect a number
> of cases where we need to fixup some part of the exit condition and
> possibly run the guest again, before having restored the host state.
> 
> This includes populating missing fault info, emulating GICv2 CPU
> interface accesses when mapped at unaligned addresses, and emulating
> the GICv3 CPU interface on systems that need it.
> 
> As we are about to have an alternative switch function for VHE systems,
> but VHE systems still need the same early fixup logic, factor out this
> logic into a separate function that can be shared by both switch
> functions.
> 
> No functional change.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp/switch.c | 104 ++++++++++++++++++++++++--------------------
>  1 file changed, 57 insertions(+), 47 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
