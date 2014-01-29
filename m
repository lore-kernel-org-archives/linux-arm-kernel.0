From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Jan 2014 07:44:11 -0800
Subject: [PATCH v2] ARM: mm: Fix stage-2 device memory attributes
In-Reply-To: <52E8DA5D.9030101@arm.com>
References: <1390944264-3435-1-git-send-email-christoffer.dall@linaro.org>
 <52E8DA5D.9030101@arm.com>
Message-ID: <20140129154411.GB3570@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 10:39:25AM +0000, Marc Zyngier wrote:
> On 28/01/14 21:24, Christoffer Dall wrote:
> > The stage-2 memory attributes are distinct from the Hyp memory
> > attributes and the Stage-1 memory attributes.  We were using the stage-1
> > memory attributes for stage-2 mappings causing device mappings to be
> > mapped as normal memory.  Add the S2 equivalent defines for memory
> > attributes and fix the comments explaining the defines while at it.
> > 
> > Add a prot_pte_s2 field to the mem_type struct and fill out the field
> > for device mappings accordingly.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Thanks, Catalin, Russell, any comments?

-Christoffer
