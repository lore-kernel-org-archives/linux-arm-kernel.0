From: plaes@plaes.org (Priit Laes)
Date: Thu, 02 Jun 2016 07:42:26 +0300
Subject: [linux-sunxi] Re: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <20160601180056.GA4908@lukather>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk> <20160601180056.GA4908@lukather>
Message-ID: <1464842546.23881.3.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-06-01 at 20:00 +0200, Maxime Ripard wrote:
> Hi,
> 
> On Mon, May 30, 2016 at 04:50:16PM +0100, Mark Brown wrote:
> > 
> > On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
> > > 
> > > On 30 May 2016 at 17:03, Mark Brown <broonie@kernel.org> wrote:
> > > 
> > > > 
> > > > I really don't think it's worth caring too much about cases
> > > > where the
> > > > DMA driver hasn't been compiled in, it's not like SPI is the
> > > > only thing
> > > 
> > > It's what the driver did to start with and it was requested to
> > > fall
> > > back to non-DMA in the case DMA is not available.
> > Why???I really can't see any sensible use case for this that
> > doesn't
> > have a better solution available.
> SPI works just fine without DMA, which might just be considered an
> (optional) optimisation.
> 
> We've been using it without DMA for years now, and it was working
> just
> fine, and it will work even better with the other patches in this
> serie. There's no reason to add a hard dependency on something that
> we
> don't really need.
> 

Actually it non-DMA case works fine if you don't need SPI transfers
larger than?SUN4I_FIFO_DEPTH - 1, which is 63 bytes.

This was addressed by this patch, but was never applied:
http://permalink.gmane.org/gmane.linux.kernel.spi.devel/18950
