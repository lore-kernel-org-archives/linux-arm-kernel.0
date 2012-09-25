From: scottwood@freescale.com (Scott Wood)
Date: Tue, 25 Sep 2012 14:59:11 -0500
Subject: [RFC PATCH 0/3] ARM: use C pre-processor with dtc
In-Reply-To: <20120925195127.GA19350@sirena.org.uk> (from
 broonie@opensource.wolfsonmicro.com on Tue Sep 25 14:51:27 2012)
Message-ID: <1348603151.5565.20@snotra>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 02:51:27 PM, Mark Brown wrote:
> On Tue, Sep 25, 2012 at 02:35:46PM -0500, Scott Wood wrote:
> 
> > Do you have an example of where you'd actually benefit from this?
> > I'd think most things could either be done reasonably well with
> > what's built into DTC (see what we've done in
> > arch/powerpc/boot/dts/fsl), or would need math expression support in
> > DTC (or has that been added?).
> 
> The constant example is the magic numbers we need to embed into DTs  
> for
> things like interrupt modes, making them human readable would be a  
> real
> win.

Wasn't there a patch for named constant support in dtc a while back?
Hmm:  
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-January/011184.html

I'm not sure that going down the CPP path is better than the  
possibility of named constants having a different syntax from  
macros/functions.  It would be one thing if someone were actively  
working on the latter, but this paralysis seems to be a case of the  
perfect being the enemy of the good.

-Scott
