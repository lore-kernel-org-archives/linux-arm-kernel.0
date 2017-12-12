From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 12 Dec 2017 17:47:21 +0100
Subject: [PATCH v3 14/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl
In-Reply-To: <20171211152226.GJ910@cbox>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-15-cdall@kernel.org>
 <20171211141241.2129a84c.cohuck@redhat.com> <20171211152226.GJ910@cbox>
Message-ID: <0a6052a0-29d3-5a5e-b0c2-1d99804bcba4@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/2017 16:22, Christoffer Dall wrote:
> I find the special casing with the immediate return a bit ugly. Maybe
> introduce a helper async_vcpu_ioctl() or so that sets -ENOIOCTLCMD in
> its default case and return here if ret != -ENOIOCTLCMD? Christian,
> what do you think?

I'll post my attempt at it shortly.

Thanks,

Paolo
