From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 9 Dec 2015 19:17:42 -0500
Subject: [PATCH 0/6] drivers/dma: drop modular code from non modular
 drivers
In-Reply-To: <7162994.ydt4N8UgZZ@wuerfel>
References: <1449703322-17762-1-git-send-email-paul.gortmaker@windriver.com>
 <7162994.ydt4N8UgZZ@wuerfel>
Message-ID: <20151210001741.GT22885@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Re: [PATCH 0/6] drivers/dma: drop modular code from non modular drivers] On 10/12/2015 (Thu 00:29) Arnd Bergmann wrote:

> On Wednesday 09 December 2015 18:21:56 Paul Gortmaker wrote:
> > This series of commits is a slice of a larger project to ensure
> > people don't have dead code for module removal in non-modular
> > drivers.  Overall there is roughly 5k lines of dead code in the
> > kernel due to this.
> > 
> > There is a quasi-separate theme, in that some of the drivers were
> > allowing an unbind implicitly since it is enabled by default.  But
> > for core DMA infrastructure drivers, this doesn't seem useful -- so
> > we also disable that here which allows us to delete any ".remove"
> > functions from the drivers that would otherwise be called during the
> > (impossible to trigger) module removal.
> > 
> > Since ARM covers these files the best of all architectures, each
> > file was build tested for allmodconfig on ARM, which at the same
> > time confirms that the files are not built with "CC [M]" -- hence
> > genuinely non-modular.
> > 
> > My testing and the larger patch series in general has been done
> > against the latest linux-next tree.
> > 
> > 
> 
> We are in the process of changing the DMA drivers to a new way of
> passing the "filter" function around. We can soon build them
> all as loadable modules again.

Hi Arnd,

Thanks for the feedback -- just to clarify, you are suggesting I hold
on the series until I see what emerges in the next merge window?

Paul.
--

> 
> 	Arnd
