From: oss@buserror.net (Scott Wood)
Date: Mon, 03 Apr 2017 19:32:33 -0500
Subject: [RFC PATCH 4/5] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
In-Reply-To: <VI1PR04MB32166AA6361CD6F24DBC3AAF86080@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-5-git-send-email-roy.pledge@nxp.com>
 <20170403154229.mf63zeiwv5naxyrr@rob-hp-laptop>
 <VI1PR04MB32166AA6361CD6F24DBC3AAF86080@VI1PR04MB3216.eurprd04.prod.outlook.com>
Message-ID: <1491265953.2944.78.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-04-03 at 19:49 +0000, Roy Pledge wrote:
> On 4/3/2017 11:42 AM, Rob Herring wrote:
> > 
> > On Wed, Mar 29, 2017 at 05:13:56PM -0400, Roy Pledge wrote:
> > > 
> > > Updates the QMan and BMan device tree bindings for reserved memory
> > > nodes. This makes the reserved memory allocation compatiable with
> > s/compatiable/compatible/
> > 
> > > 
> > > the shared-dma-pool usage.
> > This change is not backwards compatible. Please state that and explain?
> > why that is okay. If PPC needs to not change, then the old strings and?
> > properties should remain, but deprecated.
> I think I can make the old device trees compatible since the
> "compatible" string changed without too much effort or ifdefery in the
> code. ?However I would like to eventually see all PPC users move to the
> new mode as I do believe it is more in alignment with the spirit of the
> reserved-memory framework that is in the kernel.

How much benefit is there to changing PPC if you have to retain the old method
anyway for compatibility? ?Whereas if you don't convert, you retain test
coverage for the old device trees, and don't have to worry about
the?memblock_end_of_DRAM() questions.

> ??Do I need to mention the old mode in the binding.txt file??

Yes.

> ?I'm trying to keep things clean
> so someone reading the binding doesn't get a headache and trying to
> preserve my own sanity as we move forward with adding new features to
> this driver.

If they're sufficiently different then just describe the new and old nodes
separately rather than putting a bunch of if/else clauses in there.

-Scott
