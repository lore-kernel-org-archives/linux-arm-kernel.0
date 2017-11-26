From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 26 Nov 2017 10:11:08 +0100
Subject: [PATCH 00/15] Move vcpu_load and vcpu_put calls to arch code
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Message-ID: <20171126091108.GI28855@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 09:57:03PM +0100, Christoffer Dall wrote:
> Some architectures may decide to do different things during
> kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
> arm64 is about to do significant work in vcpu load/put when running a
> vcpu, but it's problematic to do this for any other vcpu ioctl than
> KVM_RUN.
> 
> Further, while it may be possible to call kvm_arch_vcpu_load() for a
> number of non-KVM_RUN ioctls, it makes the KVM/ARM code more difficult
> to reason about, especially after my optimization series, because a lot
> of things can now happen, where we have to consider if we're really in
> the process of running a vcpu or not.
> 
> This series will first move the vcpu_load() and vcpu_put() calls in the
> arch generic dispatch function into each case of the switch statement
> and then, one-by-one, pushed the calls down into the architecture
> specific code making the changes for each ioctl as required.
> 
And the patches are also available at:

git://git.kernel.org/pub/scm/linux/kernel/git/cdall/linux.git vcpu-load-put

Thanks,
-Christoffer
