From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 25 Nov 2014 12:10:34 +0100
Subject: [PATCH v2 3/3] KVM: arm/arm64: Enable Dirty Page logging for ARMv8
In-Reply-To: <5473A188.4030709@samsung.com>
References: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
 <1416039550-28125-4-git-send-email-m.smarduch@samsung.com>
 <20141122200254.GS3401@cbox> <5473A188.4030709@samsung.com>
Message-ID: <20141125111034.GF31297@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 24, 2014 at 01:22:16PM -0800, Mario Smarduch wrote:
> On 11/22/2014 12:02 PM, Christoffer Dall wrote:
> > On Sat, Nov 15, 2014 at 12:19:10AM -0800, m.smarduch at samsung.com wrote:
> >> From: Mario Smarduch <m.smarduch@samsung.com>
> >>
> >> This patch enables ARMv8 ditry page logging support. Plugs ARMv8 into generic
> >> layer through Kconfig symbol, and drops earlier ARM64 constraints to enable
> >> logging at architecture layer.
> >>
> >> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> > 
> > Just reminding you again of what I said in the previous thread (think
> > that was before you sent this out), that you need to handle the pud_huge
> > case in arch/arm/kvm/mmu.c for ARMv8 here.
> > 
> > -Christoffer
> > 
> 
> 
>   Yes, so like similar handling to what unmap_puds() does when
> it encounters a PUD Block?

yes

> 
> Should next revision be rebased to 'queued' 3.18.0-rc2?
> 

rebase onto kvmarm/next whenever we move that to kvm/next after the
merge window (keep an eye out), typically it will be 3.19-rc1 + some
stuff from Paolo.

-Christoffer
