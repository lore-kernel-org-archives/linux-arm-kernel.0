From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 2 Mar 2017 13:59:17 +0100
Subject: [PATCH] arm64: KVM: VHE: Clear HCR_TGE when invalidating guest
 TLBs
In-Reply-To: <20170227152437.26261-1-marc.zyngier@arm.com>
References: <20170227152437.26261-1-marc.zyngier@arm.com>
Message-ID: <20170302125917.GK1409@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 03:24:37PM +0000, Marc Zyngier wrote:
> When invalidating guest TLBs, special care must be taken to
> actually shoot the guest TLBs and not the host ones if we're
> running on a VHE system.  This is controlled by the HCR_EL2.TGE
> bit, which we forget to clear before invalidating TLBs.
> 
> Address the issue by introducing two wrappers (__tlb_switch_to_guest
> and __tlb_switch_to_host) that take care of both the VTTBR_EL2
> and HCR_EL2.TGE switching.
> 
> Reported-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
> Tested-by: Tomasz Nowicki <tnowicki@caviumnetworks.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <cdall@linaro.org>
