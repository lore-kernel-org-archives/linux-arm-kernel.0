From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 20 Jan 2017 20:57:22 +0100
Subject: [PATCH v10 8/8] arm/arm64: Documentation: Update arm-vgic-v3.txt
In-Reply-To: <7d82df18-debd-72e7-af6e-3816b8aaee85@redhat.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-9-git-send-email-vijay.kilari@gmail.com>
 <7d82df18-debd-72e7-af6e-3816b8aaee85@redhat.com>
Message-ID: <20170120195722.GJ13531@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 16, 2016 at 01:18:09PM +0100, Auger Eric wrote:
> Hi Vijaya,
> 
> On 01/12/2016 08:09, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> > 
> > Update error code returned for Invalid CPU interface register
> > value and access in AArch32 mode.
> > 
> > Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> > ---
> >  Documentation/virtual/kvm/devices/arm-vgic-v3.txt | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > index 9348b3c..0f29850 100644
> > --- a/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > +++ b/Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> > @@ -142,10 +142,12 @@ Groups:
> >      KVM_DEV_ARM_VGIC_CPU_SYSREGS accesses the CPU interface registers for the
> >      CPU specified by the mpidr field.
> >  
> > +    CPU interface registers access is not implemented for AArch32 mode.
> > +    Error -ENXIO is returned when accessed in AArch32 mode.
> >    Errors:
> >      -ENXIO: Getting or setting this register is not yet supported
> >      -EBUSY: VCPU is running
> > -    -EINVAL: Invalid mpidr supplied
> > +    -EINVAL: Invalid mpidr or register value supplied
> >  
> >  
> >    KVM_DEV_ARM_VGIC_GRP_NR_IRQS
> > @@ -193,6 +195,11 @@ Groups:
> >  
> >  	Bit[n] indicates the status for interrupt vINTID + n.
> >  
> > +	Getting or setting the level info for an edge-triggered interrupt is
> > +	not guaranteed to work.
> I don't get this statement. is the API applicable to edge triggered IRQs?
> 

I guess this could be clarified to "is ignored", but with the earlier
implementation you might be able to get away with doing
"line_level=x; config=LEVEL;", but you could then at the same time break
something with edge-triggered IRQs, so...


Thanks for looking at this in detail.

-Christoffer
