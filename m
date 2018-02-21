From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:49:24 +0100
Subject: [PATCH v4 22/40] KVM: arm64: Don't save the host ELR_EL2 and
 SPSR_EL2 on VHE systems
In-Reply-To: <20180215210332.8648-23-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-23-christoffer.dall@linaro.org>
Message-ID: <20180221174924.lazhs44fi4qmvend@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:03:14PM +0100, Christoffer Dall wrote:
> On non-VHE systems we need to save the ELR_EL2 and SPSR_EL2 so that we can
> return to the host in EL1 in the same state and location where we issued a
> hypercall to EL2, but on VHE ELR_EL2 and SPSR_EL2 are not useful because we
> never enter a guest as a result of an exception entry that would be directly
> handled by KVM. The kernel entry code already saves ELR_EL1/SPSR_EL1 on
> exception entry, which is enough.  Therefore, factor out these registers into
> separate save/restore functions, making it easy to exclude them from the VHE
> world-switch path later on.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm64/kvm/hyp/sysreg-sr.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
