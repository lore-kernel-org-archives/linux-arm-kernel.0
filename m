From: cohuck@redhat.com (Cornelia Huck)
Date: Mon, 11 Dec 2017 13:15:55 +0100
Subject: [PATCH v3 07/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
In-Reply-To: <20171204203538.8370-8-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-8-cdall@kernel.org>
Message-ID: <20171211131555.7eae512e.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  4 Dec 2017 21:35:29 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_set_sregs().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/powerpc/kvm/book3s.c |  8 +++++++-
>  arch/powerpc/kvm/booke.c  | 15 +++++++++++----
>  arch/s390/kvm/kvm-s390.c  |  4 ++++
>  arch/x86/kvm/x86.c        | 13 ++++++++++---
>  virt/kvm/kvm_main.c       |  2 --
>  5 files changed, 32 insertions(+), 10 deletions(-)

With David's suggestions included:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
