From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 30 Sep 2013 11:42:45 -0600
Subject: [PATCH v2 1/3] ARM: kirkwood: Remove kirkwood_setup_wins and
 rely on the DT binding (Was Re: ..)
In-Reply-To: <20130929203314.GA2457@localhost>
References: <20130917184146.GD21230@obsidianresearch.com>
 <20130929203314.GA2457@localhost>
Message-ID: <20130930174245.GB28898@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 05:33:15PM -0300, Ezequiel Garcia wrote:
> Hi Jason,
> 
> Sorry for the delayed review. I finally found some time off
> to take a deeper look at this series.
> 
> So, despite the wrong subject this is v2 for:
> 
> "ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding"
> 
> Right? I took the liberty of fixing the subject.

Yes, sorry, mailer trouble. I finally got git send-email working here
so that shouldn't happen again :)
 
> I think a small cover-letter would have been nice, just to have
> some context about the three patches. I assume the series is:
> 
> ARM: kirkwood: Remove kirkwood_setup_wins and rely on the DT binding
> ARM: kirkwood: Move the crypto node under the mbus node
> ARM: kirkwood: Move the nand node under the mbus node

Yes, that looks right.

> >  		compatible = "marvell,kirkwood-mbus", "simple-bus";
> >  		#address-cells = <2>;
> >  		#size-cells = <1>;
> > +		/* If a board file needs to change this ranges it must replace it completely */
> 
> I'd rather have a longer comment in here, explaining why such
> replacement is needed and how the 'ranges' entries are not inherited
> in any way.

Generally I try to avoid explaining how a language works in
comments :) 

> Other than that, the patch looks good:
> 
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 
> And, in Openblocks-A6:
> 
> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Did you test patch #2 as well? 

I put the 3 patches on my github:

https://github.com/jgunthorpe/linux/tree/kirkwood-mbus

Jason C: Do you want me to repost the patches?

Thanks,
Jason
