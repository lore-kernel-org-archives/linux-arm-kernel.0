From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 2 Oct 2013 11:32:12 -0700
Subject: [PATCH v5 0/4] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <524C4725.3060700@arm.com>
References: <1380531008-15901-1-git-send-email-anup.patel@linaro.org>
 <20131002160444.GA49034@lvm> <524C4725.3060700@arm.com>
Message-ID: <20131002183212.GB5108@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 05:17:41PM +0100, Marc Zyngier wrote:
> On 02/10/13 17:04, Christoffer Dall wrote:
> > On Mon, Sep 30, 2013 at 02:20:04PM +0530, Anup Patel wrote:
> >> It will be very useful for user space (QEMU/KVMTOOL) if it has a
> >> method of querying VCPU target type matching to underlying Host.
> >> We can use such querying mechanism and implement machine models
> >> in user space where VCPU target type is always same-as/similar-to
> >> underlying Host (i.e. Target CPU=Host).
> >>
> >> This patch series implements KVM_ARM_PREFERRED_TARGET vm ioclt for
> >> querying VCPU target type matching underlying host. Using this new
> >> ioctl we can implement VCPU target CPU=Host in user space.
> >>
> >> Also, it is not mandatory to call KVM_ARM_PREFERRED_TARGET vm ioctl
> >> and the old method of trying all possible target types using the
> >> KVM_ARM_VCPU_INIT ioctl to initialize VCPU works fine.
> >>
> > Looks good to me, as soon as Marc acks this one, I'll merge it.
> 
> Yup, go for it:
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Cool, merged in kvm-arm-next, tested with changes to experimental qemu
mach-virt patches on vexpress TC2.

-Christoffer
