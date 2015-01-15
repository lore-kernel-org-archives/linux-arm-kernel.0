From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 15 Jan 2015 12:42:51 +0000
Subject: [PATCHv2 0/7] arm64/kvm: common ESR_ELx definitions and decoding
In-Reply-To: <20150112194440.GB26222@cbox>
References: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
 <20150112194440.GB26222@cbox>
Message-ID: <20150115124251.GE16217@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 07:44:40PM +0000, Christoffer Dall wrote:
> On Mon, Jan 12, 2015 at 04:45:13PM +0000, Mark Rutland wrote:
> > Currently we have two sets of macros used for ESR_ELx handling, one used
> > by core arm64 code and the other used by KVM. These differ slightly in
> > naming convention and style of definition.
> > 
> > This patch series introduces and migrates all users to a common set of
> > macros for ESR_ELx handling, preventing further drift.
> > 
> > Additionally this series adds exception class decoding when reporting
> > exceptions, saving deveopers from having to perform tedious mental
> > arithmetic to figure out what the likely cause of an unexpected
> > exception was.
> > 
> > Since v1 [1]:
> > * Reorder patches to maintain KVM bisectability.
> > * Fix bad definitions (ESR_ELx_SAS and ESR_ELx_FSC_PERM).
> > * Introcuce ESR_ELx_SAS_SHIFT and undo bad rework of 
> >   kvm_vcpu_dabt_get_as.
> > * Make "Unallocated EC" comments consistent in ESR_ELx_EC_* definition
> >   list.
> > 
> For the series:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> I also tested this with KVM on APM XGene and Juno with UEFI+Linux as a
> guest.

Thanks, Christoffer. It's much appreciated.

Catalin, Christoffer, do you have a preferred path for merging this?
Should this go through the arm64 or KVM tree as a whole?

For now I've placed the whole series on a branch based on v3.19-rc3:

git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/common-esr-macros

Thanks,
Mark.
