From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 22 Feb 2018 19:15:20 +0100
Subject: [PATCH v4 30/40] KVM: arm64: Defer saving/restoring 32-bit
 sysregs to vcpu load/put
In-Reply-To: <861shel34i.wl-marc.zyngier@arm.com>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-31-christoffer.dall@linaro.org>
 <861shel34i.wl-marc.zyngier@arm.com>
Message-ID: <20180222181520.GU29376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 04:27:25PM +0000, Marc Zyngier wrote:
> On Thu, 15 Feb 2018 21:03:22 +0000,
> Christoffer Dall wrote:
> > 
> > When running a 32-bit VM (EL1 in AArch32), the AArch32 system registers
> > can be deferred to vcpu load/put on VHE systems because neither
> > the host kernel nor host userspace uses these registers.
> > 
> > Note that we can not defer saving DBGVCR32_EL2 conditionally based
> > on the state of the debug dirty flag on VHE, but since we do the
> > load/put pretty rarely, this comes out as a win anyway.
> 
> I'm not sure I understand that comment. We don't have any deferring
> for this register, so the load/put reference seems out of place.
> 

Yeah, this is a patch description editing snafu.  I'll fix it.

Thanks,
-Christoffer
