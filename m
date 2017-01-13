From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 13 Jan 2017 14:55:45 +0000
Subject: [PATCH 2/3] KVM: arm64: Access CNTHCTL_EL2 bit fields correctly
 on VHE systems
In-Reply-To: <20170113144204.GB2472@leverpostej>
References: <1484307093-29153-1-git-send-email-marc.zyngier@arm.com>
 <1484307093-29153-3-git-send-email-marc.zyngier@arm.com>
 <20170113123612.GA31994@cbox>
 <d496020c-a097-ffd5-adb7-7edb7c1a214e@arm.com>
 <20170113144204.GB2472@leverpostej>
Message-ID: <20170113145545.GD2472@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 02:42:04PM +0000, Mark Rutland wrote:
> On Fri, Jan 13, 2017 at 01:30:29PM +0000, Marc Zyngier wrote:
> > On 13/01/17 12:36, Christoffer Dall wrote:
> > > Further, are we guaranteed that the static branch gets compiled into
> > > something that doesn't actually look at cpu_hwcap_keys, which is not
> > > mapped in hyp mode?
> 
> If I disable CONFIG_JUMP_LABEL (which lives under "General setup", with
> teh title "Optimize very unlikely/likely branches"), I see adrp; add;
> ldr sequences accessing cpu_hwcap_keys when using cpus_have_const_cap()
> in hyp code, even with the patch below.

Looking again, that's the same sequence Marc mentioned, as it falls in
the BSS. I just happened to be looking at the unlinked .o file rather
than the vmlinux.

Sorry for the noise.

Thanks,
Mark.
