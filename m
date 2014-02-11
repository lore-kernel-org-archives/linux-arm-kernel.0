From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 11 Feb 2014 13:39:32 +0000
Subject: [PATCH 4/7] spi: pl022: attempt to get sspclk by name
In-Reply-To: <20140211120645.GH13533@sirena.org.uk>
References: <1392118632-11312-1-git-send-email-mark.rutland@arm.com>
 <1392118632-11312-5-git-send-email-mark.rutland@arm.com>
 <20140211120645.GH13533@sirena.org.uk>
Message-ID: <20140211133932.GC1067@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 12:06:45PM +0000, Mark Brown wrote:
> On Tue, Feb 11, 2014 at 11:37:09AM +0000, Mark Rutland wrote:
> 
> > -	pl022->clk = devm_clk_get(&adev->dev, NULL);
> > +	/*
> > +	 * For compatibility with old DTBs and platform data, fall back to the
> > +	 * first clock if there's not an explicitly named "sspclk" entry.
> > +	 */
> > +	pl022->clk = devm_clk_get(&adev->dev, "sspclk");
> > +	if (IS_ERR(pl022->clk))
> > +		pl022->clk = devm_clk_get(&adev->dev, NULL);
> > +
> 
> I'll just have a bit of a grumble here and point out that this sort of
> stuff always worries me with the convention of using nameless clocks -
> it causes hassle adding further clocks.
>
> In any case you didn't CC me on the cover letter or any of the non-SPI
> patches so I'm not sure what the dependencies are here (if there are
> any), does the series need to go in as one?

Apologies for missing you for the cover letter (you can find a copy in
the lakml archive [1]).

The SPI patches don't depend on the rest of the series, but given
Russell's comments on the cover [2] this will probably need a v2 anyway.
I'll ensure you're Cc'd.

Cheers,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231572.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231594.html
