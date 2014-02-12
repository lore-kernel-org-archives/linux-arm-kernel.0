From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 14:03:26 +0100
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <201402121221.51233.arnd@arndb.de>
 <20140212114740.GE21992@e106331-lin.cambridge.arm.com>
Message-ID: <1786282.mNUF0ZaUg2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 11:47:40 Mark Rutland wrote:
> On Wed, Feb 12, 2014 at 11:21:50AM +0000, Arnd Bergmann wrote:
> > On Wednesday 12 February 2014, Mark Rutland wrote:
> > > To me it feels odd to require the last clock in the list (apb_pclk) to
> > > be named, and the rest to be in a particular order. For the dt case it
> > > seems saner to add new clocks with names as it allows arbitrary subsets
> > > of clocks to be wired up and described (though obviously in this case a
> > > missing sspclk would be problematic).
> > 
> > Yes, good point about the missing clocks, and I also agree mixing ordered
> > and named clocks in one device is rather odd and can lead to trouble.
> > 
> > I guess there isn't really a good way out here, and I certainly won't
> > ask for it to be done one way or the other if someone else has a 
> > good argument which way it should be implemented.
> 
> Having thought about it, all dts that for the ssp_pclk must have some
> name for the sspclk (though the specific name is arbitrary). I could get
> the driver to try each of those before falling back to the index
> (perhaps with a helper that takes a list of known aliases), so all
> existing dts (that we are aware of) would work with the clock requested
> by name.

Strange. Why do the even have names in there? What are those strings?

I noticed that ux500 has uses four different strings, one for each
instance, which is obviously a bug and should just be fixed. There is
no way this was intentional, and we can just rely on teh fallback
if you want to have that anyway.

> I assume that for the non-dt case it's possible to name clock inputs to
> a device without the clock being associated with the name globally? If
> so we could get rid of the index usage entirely in this case.

Sorry, I don't understand the question.

	Arnd
