From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 11 Dec 2013 12:52:07 -0800
Subject: [RESEND PATCH v2] arm/arm64: kvm: Use virt_to_idmap instead of
 virt_to_phys for idmap mappings
In-Reply-To: <52A83809.4080206@arm.com>
References: <1384891152-15990-1-git-send-email-santosh.shilimkar@ti.com>
 <52A76F4D.3030803@ti.com> <20131211002301.GD2871@cbox>
 <52A83809.4080206@arm.com>
Message-ID: <20131211205207.GG2871@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 10:01:45AM +0000, Marc Zyngier wrote:
> On 11/12/13 00:23, Christoffer Dall wrote:
> > On Tue, Dec 10, 2013 at 02:45:17PM -0500, Santosh Shilimkar wrote:
> >> Christoffer,
> >>
> >> On Tuesday 19 November 2013 02:59 PM, Santosh Shilimkar wrote:
> >>> KVM initialisation fails on architectures implementing virt_to_idmap()
> >>> because virt_to_phys() on such architectures won't fetch you the correct
> >>> idmap page.
> >>>
> >>> So update the KVM ARM code to use the virt_to_idmap() to fix the issue.
> >>> Since the KVM code is shared between arm and arm64, we create
> >>> kvm_virt_to_phys() and handle the redirection in respective headers.
> >>>
> >>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> >>> Cc: Marc Zyngier <marc.zyngier@arm.com>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >>> ---
> >>> Update the earlier version as per Marc's suggestion
> >>>
> >> Have you picked this up for 3.14 ?
> >>
> > 
> > Actually, I was waiting for Marc to ack this one.  Marc?
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> 	M.

Thanks, applied.

-Christoffer
