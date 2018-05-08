From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 8 May 2018 09:56:50 +0100
Subject: [PATCH v5 03/14] KVM: arm/arm64: Introduce
 kvm_arch_vcpu_run_pid_change
In-Reply-To: <1525449935-31424-4-git-send-email-Dave.Martin@arm.com>
References: <1525449935-31424-1-git-send-email-Dave.Martin@arm.com>
 <1525449935-31424-4-git-send-email-Dave.Martin@arm.com>
Message-ID: <dc6f60a2-f0d8-f511-d320-6d69668b5a4b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 17:05, Dave Martin wrote:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> KVM/ARM differs from other architectures in having to maintain an
> additional virtual address space from that of the host and the
> guest, because we split the execution of KVM across both EL1 and
> EL2.
> 
> This results in a need to explicitly map data structures into EL2
> (hyp) which are accessed from the hyp code.  As we are about to be
> more clever with our FPSIMD handling on arm64, which stores data in
> the task struct and uses thread_info flags, we will have to map
> parts of the currently executing task struct into the EL2 virtual
> address space.
> 
> However, we don't want to do this on every KVM_RUN, because it is a
> fairly expensive operation to walk the page tables, and the common
> execution mode is to map a single thread to a VCPU.  By introducing
> a hook that architectures can select with
> HAVE_KVM_VCPU_RUN_PID_CHANGE, we do not introduce overhead for
> other architectures, but have a simple way to only map the data we
> need when required for arm64.
> 
> This patch introduces the framework only, and wires it up in the
> arm/arm64 KVM common code.
> 
> No functional change.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
