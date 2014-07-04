From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 4 Jul 2014 03:13:02 -0700
Subject: [PATCH] arm64: KVM: export demux regids as KVM_REG_ARM64
In-Reply-To: <53B2DA42.40604@arm.com>
References: <1404229993-14522-1-git-send-email-alex.bennee@linaro.org>
 <53B2DA42.40604@arm.com>
Message-ID: <20140704101302.GD20451@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 04:56:50PM +0100, Marc Zyngier wrote:
> On 01/07/14 16:53, Alex Benn?e wrote:
> > I suspect this is a -ECUTPASTE fault from the initial implementation. If
> > we don't declare the register ID to be KVM_REG_ARM64 the KVM_GET_ONE_REG
> > implementation kvm_arm_get_reg() returns -EINVAL and hilarity ensues.
> > 
> > The kvm/api.txt document describes all arm64 registers as starting with
> > 0x60xx... (i.e KVM_REG_ARM64).
> > 
> > Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> > Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  arch/arm64/kvm/sys_regs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 0324458..5ee99e4 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -962,7 +962,7 @@ static unsigned int num_demux_regs(void)
> >  
> >  static int write_demux_regids(u64 __user *uindices)
> >  {
> > -	u64 val = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
> > +	u64 val = KVM_REG_ARM64 | KVM_REG_SIZE_U32 | KVM_REG_ARM_DEMUX;
> >  	unsigned int i;
> >  
> >  	val |= KVM_REG_ARM_DEMUX_ID_CCSIDR;
> > 
> 
> -EBROWNPAPERBAG.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Applied to kvmarm/master,

thanks.
