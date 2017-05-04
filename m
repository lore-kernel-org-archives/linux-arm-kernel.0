From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 4 May 2017 13:45:44 +0100
Subject: [PATCH] KVM: arm/arm64: Move shared files to virt/kvm/arm
In-Reply-To: <20170504123311.25252-1-cdall@linaro.org>
References: <20170504123311.25252-1-cdall@linaro.org>
Message-ID: <39ab7af1-618f-59db-f84d-bc9aa9102dd4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/17 13:33, Christoffer Dall wrote:
> For some time now we have been having a lot of shared functionality
> between the arm and arm64 KVM support in arch/arm, which not only
> required a horrible inter-arch reference from the Makefile in
> arch/arm64/kvm, but also created confusion for newcomers to the code
> base, as was recently seen on the mailing list.
> 
> Further, it causes confusion for things like cscope, which needs special
> attention to index specific shared files for arm64 from the arm tree.
> 
> Move the shared files into virt/kvm/arm and move the trace points along
> with it.  When moving the tracepoints we have to modify the way the vgic
> creates definitions of the trace points, so we take the chance to
> include the VGIC tracepoints in its very own special vgic trace.h file.
> 
> Signed-off-by: Christoffer Dall <cdall@linaro.org>
> ---
> Hi Marc,
> 
> What do you think of this?  If you like it, I think we should include it
> for this merge window.

I think we should have done that a while ago!

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
