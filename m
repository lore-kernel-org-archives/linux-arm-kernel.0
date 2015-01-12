From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 12 Jan 2015 20:44:40 +0100
Subject: [PATCHv2 0/7] arm64/kvm: common ESR_ELx definitions and decoding
In-Reply-To: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
References: <1421081120-7694-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20150112194440.GB26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 12, 2015 at 04:45:13PM +0000, Mark Rutland wrote:
> Currently we have two sets of macros used for ESR_ELx handling, one used
> by core arm64 code and the other used by KVM. These differ slightly in
> naming convention and style of definition.
> 
> This patch series introduces and migrates all users to a common set of
> macros for ESR_ELx handling, preventing further drift.
> 
> Additionally this series adds exception class decoding when reporting
> exceptions, saving deveopers from having to perform tedious mental
> arithmetic to figure out what the likely cause of an unexpected
> exception was.
> 
> Since v1 [1]:
> * Reorder patches to maintain KVM bisectability.
> * Fix bad definitions (ESR_ELx_SAS and ESR_ELx_FSC_PERM).
> * Introcuce ESR_ELx_SAS_SHIFT and undo bad rework of 
>   kvm_vcpu_dabt_get_as.
> * Make "Unallocated EC" comments consistent in ESR_ELx_EC_* definition
>   list.
> 
For the series:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

I also tested this with KVM on APM XGene and Juno with UEFI+Linux as a
guest.

Thanks,
-Christoffer
