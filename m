From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 1 Jun 2016 20:00:56 +0200
Subject: [PATCH 5/5] RFC spi: sun4i: add DMA support
In-Reply-To: <20160530155016.GO29837@sirena.org.uk>
References: <cover.1464130597.git.hramrach@gmail.com>
 <ba0d6eb37cc4b0d2c46acbf9fcd7d644b3545ce8.1464130597.git.hramrach@gmail.com>
 <20160530112610.GJ29837@sirena.org.uk>
 <CAMuHMdVThvtqgFnyqoqypwwf1d81uu9NBo6-heTZBcvBxRevNw@mail.gmail.com>
 <20160530150343.GL29837@sirena.org.uk>
 <CAOMqctQb-YYprA7H5qCcYo2hxXiUhjW2z3JbZ3-FhbfcjFzBpw@mail.gmail.com>
 <20160530155016.GO29837@sirena.org.uk>
Message-ID: <20160601180056.GA4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 30, 2016 at 04:50:16PM +0100, Mark Brown wrote:
> On Mon, May 30, 2016 at 05:28:10PM +0200, Michal Suchanek wrote:
> > On 30 May 2016 at 17:03, Mark Brown <broonie@kernel.org> wrote:
> 
> > > I really don't think it's worth caring too much about cases where the
> > > DMA driver hasn't been compiled in, it's not like SPI is the only thing
> 
> > It's what the driver did to start with and it was requested to fall
> > back to non-DMA in the case DMA is not available.
> 
> Why?  I really can't see any sensible use case for this that doesn't
> have a better solution available.

SPI works just fine without DMA, which might just be considered an
(optional) optimisation.

We've been using it without DMA for years now, and it was working just
fine, and it will work even better with the other patches in this
serie. There's no reason to add a hard dependency on something that we
don't really need.

Maxime


-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160601/10a3f78e/attachment.sig>
