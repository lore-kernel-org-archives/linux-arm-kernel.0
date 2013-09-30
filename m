From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 30 Sep 2013 14:56:12 -0300
Subject: [PATCH v2 1/3] ARM: kirkwood: Remove kirkwood_setup_wins and
 rely on the DT binding (Was Re: ..)
In-Reply-To: <20130930174245.GB28898@obsidianresearch.com>
References: <20130917184146.GD21230@obsidianresearch.com>
 <20130929203314.GA2457@localhost>
 <20130930174245.GB28898@obsidianresearch.com>
Message-ID: <20130930175611.GA2607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 11:42:45AM -0600, Jason Gunthorpe wrote:
> On Sun, Sep 29, 2013 at 05:33:15PM -0300, Ezequiel Garcia wrote:
> > Hi Jason,
> > 
> > Sorry for the delayed review. I finally found some time off
> > to take a deeper look at this series.
> > 
> > So, despite the wrong subject this is v2 for:
> > 
> > "ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding"
> > 
> > Right? I took the liberty of fixing the subject.
> 
> Yes, sorry, mailer trouble. I finally got git send-email working here
> so that shouldn't happen again :)
>  
> > I think a small cover-letter would have been nice, just to have
> > some context about the three patches. I assume the series is:
> > 
> > ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding
> > ARM: kirkwood: Move the crypto node under the mbus node
> > ARM: kirkwood: Move the nand node under the mbus node
> 
> Yes, that looks right.
> 
> > >  		compatible = "marvell,kirkwood-mbus", "simple-bus";
> > >  		#address-cells = <2>;
> > >  		#size-cells = <1>;
> > > +		/* If a board file needs to change this ranges it must replace it completely */
> > 
> > I'd rather have a longer comment in here, explaining why such
> > replacement is needed and how the 'ranges' entries are not inherited
> > in any way.
> 
> Generally I try to avoid explaining how a language works in
> comments :) 
> 
> > Other than that, the patch looks good:
> > 
> > Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > 
> > And, in Openblocks-A6:
> > 
> > Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> Did you test patch #2 as well? 
> 

Well, I booted the board with the patch, but didn't do any crypto-specific
testings. That said, I don't have any strong opinion on the crypto-node moving
or splitting.

Have you worked that out?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
