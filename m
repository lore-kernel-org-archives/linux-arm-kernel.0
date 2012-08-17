From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 17 Aug 2012 14:01:51 +0300
Subject: [PATCH] ARM: LPC32xx: Provide DMA filter callbacks via platform
 data
In-Reply-To: <502E2279.1030604@antcom.de>
References: <1345122935-22115-1-git-send-email-stigge@antcom.de>
 <1345198171.27859.39.camel@sauron.fi.intel.com>
 <502E2279.1030604@antcom.de>
Message-ID: <1345201311.27859.51.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-08-17 at 12:52 +0200, Roland Stigge wrote:
> On 08/17/2012 12:09 PM, Artem Bityutskiy wrote:
> > On Thu, 2012-08-16 at 15:15 +0200, Roland Stigge wrote:
> >> The SLC and MLC NAND drivers now need their dma_filter callbacks
> >> via platform data to make them independent of single DMA engine
> >> drivers.
> >> 
> >> (This also helps fixing build errors of the SLC and MLC drivers
> >> when building as modules because direct access to AMBA dma filter
> >> functions isn't available via export.)
> >> 
> >> Signed-off-by: Roland Stigge <stigge@antcom.de>
> > 
> > Pushed the 3 patches to l2-mtd.git, thanks!
> 
> To later avoid collisions on subsystem merge, can you please leave the
> patch with arch/arm/mach-lpc32xx/phy3250.c for arm-soc.git? (I will
> provide a pull request for Arnd and Olof, as usual.)

Only if Arnd insists. Otherwise I'd prefer to resolve collisions (they
cannot be hard with this patch) than pulling the soc tree to the mtd
tree.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120817/e488c5d6/attachment.sig>
