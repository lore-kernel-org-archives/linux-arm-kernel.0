From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 15:32:00 +0100
Subject: [PATCH 10/10] spi: s3c64xx: add device tree support
In-Reply-To: <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-11-git-send-email-thomas.abraham@linaro.org>
 <20120509090716.GC28702@sirena.org.uk>
 <CAJuYYwQF9Hh3wJpPTfXm_5iirvHzgwDu6imuSgH-ggenj=Vc8Q@mail.gmail.com>
Message-ID: <20120509143159.GU3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 10:13:28PM +0800, Thomas Abraham wrote:
> On 9 May 2012 17:07, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> > On Wed, May 09, 2012 at 03:34:54AM +0530, Thomas Abraham wrote:

> >> +- gpios: The gpio specifier for clock, mosi and miso interface lines (in no
> >> + ?particular order). The format of the gpio specifier depends on the gpio
> >> + ?controller.

> > This seems odd... ?This isn't a bitbanging controller, and surely the
> > driver will need to know which signal is which? ?I suspect this is
> > actually for pinmux rather than to identify the signals but that should
> > at least be made clear and really should be being done using the pinmux
> > API.

> The driver retrieves the list of gpio's that it is allowed to use. The
> gpio numbers for miso, mosi and clk are mandatory but the order in
> which they are specified is not important since the driver never needs
> to which gpio is which interface line. I agree the pinmux api should
> be used here, but the call to pinmux api would be a incremental change
> here, not changing the code this patch is adding.

I'd suggest just specifying the order - someone might want to use it
later for some reason and it's not really a hardship for someone to use
it.  Avoids any "how does that work?" questions like I had.

> >> + ?- samsung,spi-cs-gpio: A gpio specifier that specifies the gpio line used as
> >> + ? ?the slave select line by the spi controller. The format of the gpio
> >> + ? ?specifier depends on the gpio controller.

> > We should really have a binding for this at the SPI level (and ideally
> > some code to manage setting the GPIO too) - it's pretty common to use a
> > GPIO as /CS.

> The existing implementations vary in the way the nCS gpio lines are
> specified. For some controllers, the nCS gpio's are included in the
> spi device node whereas in this implementation, the nCS gpio is listed
> in the spi slave device node.

Yeah, I know.  I'm saying we should try to come up with a binding for
this that can be used by new SPI contollers going forward so things are
consistent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/15462c0f/attachment.sig>
