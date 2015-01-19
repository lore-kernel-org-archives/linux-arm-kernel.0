From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 19 Jan 2015 14:07:52 +0100
Subject: [PATCH v7 00/20] KVM GICv3 emulation
In-Reply-To: <54BCE2B6.5030406@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
 <54BCE2B6.5030406@arm.com>
Message-ID: <20150119130752.GA3766@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

On Mon, Jan 19, 2015 at 10:55:50AM +0000, Andre Przywara wrote:
> Hi,
> 
> On 14/01/15 16:31, Andre Przywara wrote:
> > This is version 7 of the GICv3 guest emulation series.
> > As v6 this series is based on v3.19-rc3 plus Eric's explicit
> > VGIC_CTRL_INIT patches.
> 
> I've been told that there is some confusion about the above feature with
> vGICv3 and I just saw that I didn't mention it in the cover letter:
> 
> The GICv3 emulation does not support automatic init as the vGICv2 does.
> One needs to explicitly use the brand new VGIC_CTRL_INIT KVM device
> ioctl to finalise the GICv3 initialisation.
> 
> Among the three places the automatic VGIC init was done before now two
> are in vgic-v2-emul.c and don't apply to a virtual GICv3. The remaining
> place is in kvm_vgic_inject_irq() in vgic.c, where I explicitly added a
> check to only work with a virtual GICv2.
> Removing the explicit VGIC_CTRL_INIT from kvmtool resulted in the
> desired effect: the VGICv3 didn't initialise and kvmtool returned with
> an error.
> If there should be a codepath left which allows auto-init of a virtual
> GICv3, this is a bug and I'd be grateful for a report.
> 
No, I didn't realize when reading the patch for this specific issue that
the set_attr code path was moved to the gicv2 specific files.

I think you nailed it, so we should be all good.

Will queue this once I get a chance to do a shallow test for
regressions.

Thanks,
-Christoffer
