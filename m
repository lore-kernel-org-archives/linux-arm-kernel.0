From: gengdongjiu@huawei.com (gengdongjiu)
Date: Mon, 30 Oct 2017 09:13:22 +0800
Subject: [PATCH v3] KVM: arm/arm64: fix the incompatible matching for
 external abort
In-Reply-To: <861slmaha7.fsf@arm.com>
References: <1509173159-30579-1-git-send-email-gengdongjiu@huawei.com>
 <861slmaha7.fsf@arm.com>
Message-ID: <b3d95d31-acbc-3ab4-f828-bcbb2280a198@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/10/29 9:12, Marc Zyngier wrote:
> I'm sorry, but I can't manage to parse this commit message. How about
> something like this?
> 
> "kvm_vcpu_dabt_isextabt() tries to match a full fault syndrome, but
>  calls kvm_vcpu_trap_get_fault_type() that only returns the fault class,
>  thus reducing the scope of the check. This doesn't cause any observable
>  bug yet as we end-up matching a closely related syndrome for which we
>  return the same value.
> 
>  Using kvm_vcpu_trap_get_fault() instead fixes it for good"

Marc, thank you very much for your pointing out and good suggestion,
will update it. Thanks a lot.
