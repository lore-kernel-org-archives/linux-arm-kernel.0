From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Sep 2013 11:49:31 +0100
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
In-Reply-To: <CAAhSdy1ERuXR36m4eOfYkq_oe_tNobmAe=Y4zQTxQjW5GOTh7g@mail.gmail.com>
References: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
 <CAFEAcA8z+_N3UQ-RQW9u65BpGRs+aKzhr2O34yOX0DhKZCAqRg@mail.gmail.com>
 <CAAhSdy1Qyum=v3_80SvGB3rKUP_Nxqg7858Uzf4QKdQd4YvzBA@mail.gmail.com>
 <BB11B00E-5EBD-45F5-89C7-7973919F7184@suse.de>
 <20130906090623.GA30450@mudshark.cambridge.arm.com>
 <CAAhSdy1ERuXR36m4eOfYkq_oe_tNobmAe=Y4zQTxQjW5GOTh7g@mail.gmail.com>
Message-ID: <20130906104931.GC30450@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 11:09:09AM +0100, Anup Patel wrote:
> On Fri, Sep 6, 2013 at 2:36 PM, Will Deacon <will.deacon@arm.com> wrote:
> > On Fri, Sep 06, 2013 at 09:54:23AM +0100, Alexander Graf wrote:
> >> On 06.09.2013, at 09:44, Anup Patel wrote:
> >> > it hard to come up with a use case where having a separate ioctl for
> >> > "get best CPU for this host" would be better for user space.
> >>
> >> It can store it and migrate it as part of its migration protocol (probably hard for QEMU's current work flow, but that's QEMU's issue).
> >
> > It's also better from the point of view of devicetree generation. For
> > example, kvmtool needs to generate the correct architected timer interrupt
> > numbers for the target CPU, so munging this into KVM_ARM_VCPU_INIT means we
> > have to go off and figure out the host CPU separately anyway.
> 
> Please look at the patch carefully we are returning VCPU
> target type back to user space so, you can generate correct
> architected timer interrupt numbers for the target CPU.

I did look at the patch, but I also looked at the overriding consensus in
the feedback saying that you can't change the direction of the ioctl, so
that would require what I said above.

Will
