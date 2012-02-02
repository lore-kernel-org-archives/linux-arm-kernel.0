From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 1 Feb 2012 17:19:55 -0700
Subject: [RFC PATCH 4/7] ARM: davinci: net: davinci_emac: add OF support
In-Reply-To: <4F27D00F.4040807@denx.de>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-5-git-send-email-hs@denx.de>
 <20120130202208.GW28397@ponder.secretlab.ca>
 <4F27D00F.4040807@denx.de>
Message-ID: <20120202001955.GG15343@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 12:27:11PM +0100, Heiko Schocher wrote:
> Hello Grant,
> 
> Grant Likely wrote:
> > On Mon, Jan 23, 2012 at 09:56:04AM +0100, Heiko Schocher wrote:
> >> add of support for the davinci_emac driver.
> >>
> >> Signed-off-by: Heiko Schocher <hs@denx.de>
> >> Cc: davinci-linux-open-source at linux.davincidsp.com
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Cc: devicetree-discuss at lists.ozlabs.org
> >> Cc: netdev at vger.kernel.org
> >> Cc: Grant Likely <grant.likely@secretlab.ca>
> >> Cc: Sekhar Nori <nsekhar@ti.com>
> >> Cc: Wolfgang Denk <wd@denx.de>
> >> ---
> >>  .../bindings/arm/davinci/davinci_emac.txt          |   46 ++++++++
> >>  drivers/net/ethernet/ti/davinci_emac.c             |  111 +++++++++++++++++++-
> >>  2 files changed, 156 insertions(+), 1 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/arm/davinci/davinci_emac.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/arm/davinci/davinci_emac.txt b/Documentation/devicetree/bindings/arm/davinci/davinci_emac.txt
> >> new file mode 100644
> >> index 0000000..4e5dc8d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/davinci/davinci_emac.txt
> >> @@ -0,0 +1,46 @@
> >> +* Texas Instruments Davinci EMAC
> >> +
> >> +This file provides information, what the davice node
> >> +for the davinci_emac interface contain.
> >> +
> >> +Required properties:
> >> +- compatible: "ti,davinci-emac";
> >> +- reg: Offset and length of the register set for the device
> >> +- ctrl_reg_offset: offset to control register
> >> +- ctrl_mod_reg_offset: offset to control module register
> >> +- ctrl_ram_offset: offset to control module ram
> > 
> > Should these be explicit properties, or can they be discerned from the
> > compatible string (which should include the hardware version; see
> > below).
> 
> Hmm.. I do not know all davinci SoCs ... maybe someone from TI
> could answer this? But I think, we could discern this from
> the compatible string. I prepare this for v2. Maybe it is Ok,
> if I do this only for my hardwareversion and others add this,
> if needed? (maybe the better approach, as I can code it, but
> have no hw for testing it ... so it maybe is buggy)
> 
> > Also, any custom properties that are specific to a binding really
> > should include a vendor prefix ('ti,') to avoid namespace collisions
> > with common bindings.
> 
> Yep, is "ti,davinci-" ok? Also I should use dashes instead
> underscores, right?

Correct.

> 
> >> +- hw_ram_addr: hardware ram addr
> > 
> > Can this be added as a second tuple in the reg property?
> 
> No, if I know this right, this is used for DMA, and also could be RAM.

Not getting what you mean here.  The second tuple could be omitted if there
isn't a physical address for hardware ram.
