From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 4 Jun 2015 13:07:40 +0200
Subject: [PATCH v5 05/12] KVM: arm: introduce
 kvm_arm_init/setup/clear_debug
In-Reply-To: <1432891828-4816-6-git-send-email-alex.bennee@linaro.org>
References: <1432891828-4816-1-git-send-email-alex.bennee@linaro.org>
 <1432891828-4816-6-git-send-email-alex.bennee@linaro.org>
Message-ID: <20150604110740.GH7657@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 10:30:21AM +0100, Alex Benn?e wrote:
> This is a precursor for later patches which will need to do more to
> setup debug state before entering the hyp.S switch code. The existing
> functionality for setting mdcr_el2 has been moved out of hyp.S and now
> uses the value kept in vcpu->arch.mdcr_el2.
> 
> As the assembler used to previously mask and preserve MDCR_EL2.HPMN I've
> had to add a mechanism to save the value of mdcr_el2 as a per-cpu
> variable during the initialisation code. The kernel never sets this
> number so we are assuming the bootcode has set up the correct value
> here.
> 
> This also moves the conditional setting of the TDA bit from the hyp code
> into the C code which is currently used for the lazy debug register
> context switch code.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
