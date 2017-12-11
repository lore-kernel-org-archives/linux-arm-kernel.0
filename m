From: cohuck@redhat.com (Cornelia Huck)
Date: Mon, 11 Dec 2017 13:23:53 +0100
Subject: [PATCH v3 08/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_get_mpstate
In-Reply-To: <20171204203538.8370-9-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-9-cdall@kernel.org>
Message-ID: <20171211132353.33da5260.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  4 Dec 2017 21:35:30 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_get_mpstate().
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/s390/kvm/kvm-s390.c | 11 +++++++++--
>  arch/x86/kvm/x86.c       |  3 +++
>  virt/kvm/arm/arm.c       |  3 +++
>  virt/kvm/kvm_main.c      |  2 --
>  4 files changed, 15 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
