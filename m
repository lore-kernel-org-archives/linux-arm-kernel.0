From: cohuck@redhat.com (Cornelia Huck)
Date: Mon, 11 Dec 2017 13:02:39 +0100
Subject: [PATCH v3 03/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_run
In-Reply-To: <20171204203538.8370-4-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-4-cdall@kernel.org>
Message-ID: <20171211130239.3f681554.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  4 Dec 2017 21:35:25 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_run().
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/mips/kvm/mips.c       |  3 +++
>  arch/powerpc/kvm/powerpc.c |  6 +++++-
>  arch/s390/kvm/kvm-s390.c   | 10 ++++++++--
>  arch/x86/kvm/x86.c         |  3 +++
>  virt/kvm/arm/arm.c         | 15 +++++++++++----
>  virt/kvm/kvm_main.c        |  2 --
>  6 files changed, 30 insertions(+), 9 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
