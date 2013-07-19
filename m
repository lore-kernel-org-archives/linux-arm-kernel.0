From: maxime.ripard@free-electrons.com ('Maxime Ripard')
Date: Fri, 19 Jul 2013 10:35:55 +0200
Subject: [PATCH 2/3] video: hx8357: Make IM pins optional
In-Reply-To: <1373945380.7549.26.camel@marge.simpson.net>
References: <1373902022-20439-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373902022-20439-3-git-send-email-maxime.ripard@free-electrons.com>
 <003501ce81be$4a945ed0$dfbd1c70$@samsung.com>
 <1373945380.7549.26.camel@marge.simpson.net>
Message-ID: <20130719083555.GC5106@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jingoo, Mike,

On Tue, Jul 16, 2013 at 05:29:40AM +0200, Mike Galbraith wrote:
> On Tue, 2013-07-16 at 09:49 +0900, Jingoo Han wrote: 
> > On Tuesday, July 16, 2013 12:27 AM, Maxime Ripard wrote:
> 
> > > +
> > > +			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> > > +						    GPIOF_OUT_INIT_LOW, "im_pins");
> > 
> > This makes a checkpatch warning such as 'WARNING: line over 80 characters'.
> > How about the following?
> > 
> > 			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
> > 						GPIOF_OUT_INIT_LOW, "im_pins");
> 
> IIRC, some maintainers gripe (davem?) when they see such alignment,
> preferring the original arg below arg alignment vs strict 80 column.

As far as I know, the coding guide styles are quite fuzzy about this:
  - The new line is not required to be aligned with the braces above
  - Yet, the emacs config given does indent like this.
  - 80 characters is said not to be a hard limit

I don't really know if there's a better solution here, except maybe:
ret = devm_gpio_request_one(&spi-dev, lcd->im_pins[i],
			    GPIOF_OUT_INIT_LOW,
			    "im_pins");

But it's not really a big deal, is it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/bc2fea0e/attachment.sig>
