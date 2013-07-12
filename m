From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 12 Jul 2013 12:13:17 +0200
Subject: [PATCH] ASoC: Samsung: Modify the I2S driver to support I2S on
 Exynos5420
In-Reply-To: <20130711130139.GQ24508@sirena.org.uk>
References: <1373526505-27115-1-git-send-email-padma.v@samsung.com>
 <2214161.FSfscAvpna@thinkpad> <20130711130139.GQ24508@sirena.org.uk>
Message-ID: <2463181.bQfIDO6XJk@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 of July 2013 14:01:39 Mark Brown wrote:
> On Thu, Jul 11, 2013 at 01:41:40PM +0200, Tomasz Figa wrote:
> > On Thursday 11 of July 2013 12:20:23 Mark Brown wrote:
> > > This is a bit of a larger project sadly, there was resistance to doing
> > > the DT bindings based on compatible strings using the IP version :(
> > 
> > I'm not sure if this case is related to this problem in any way. I just
> > suggested introducing a new include like samsung,exynos5420-i2s, a opposed
> > to using samsung,exynos5250-i2s and adding flags, since the I2S in
> > Exynos5420 is
> Well, it *should* be samsung,i2s-vN where N is the version number of the
> IP but documentation on the versioning has been patchy hence this whole
> thinng.

Oh, the binding for samsung-i2s uses IP versions. Isn't that slightly broken?

At least with Samsung bindings, I think we happened to agree on a single 
convention of naming compatible values after the first SoC in which such block 
first appeared.

I wonder what happened with this i2s binding that made it end up outside this 
convention.

> > the first one to have this TDM or whatever mode. (I'd still like to hear
> > what it is...)
> 
> What it *should* be is the option to send more than one audio stream
> down a link using time division multiplexing.

OK.

Best regards,
Tomasz
