From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Jul 2014 13:35:57 +0100
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CABxcv==yuWJYmSiVV=HELMdwi-8aAG-aiT9o12HUBp8uRaBxkQ@mail.gmail.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
 <CABxcv==yuWJYmSiVV=HELMdwi-8aAG-aiT9o12HUBp8uRaBxkQ@mail.gmail.com>
Message-ID: <20140715123557.GB17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:38:58PM +0200, Javier Martinez Canillas wrote:
> Hello Mark,

Don't top post.

> On Mon, Jul 14, 2014 at 7:25 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 14, 2014 at 11:11:44AM +0530, Naveen Krishna Chatradhi wrote:

> So, the .line field is used to specify a GPIO, not a chip select. So
> gpio_is_valid() should also be used to check that cs->line is a valid
> GPIO. If board file does not want to use a GPIO and wants to use a
> built-in chip select then it should either not use a struct
> s3c64xx_spi_csinfo at all or set .line to -ENOENT in order to be
> consistent with the SPI core.

This sort of "let's make everyone instabuggy" change is not good
practice, especially when it's mixed in with some other not obviously
related change, has an unclear benefit and is barely mentioned in the
commit log - I found this through code review, not through it being a
clearly intentional and considered part of the change.

> As I said before this patch is fixing a bug in the SPI driver, the
> first version of the series was posted on June, 10 so many other
> patches already depend on this fix. So it would be great if we can
> move this forward since this is hurting the platform support as a
> whole.

So provide a clear, easy to understand patch series then.  As I've said
before this series is setting off lots of alarm bells - the large number
of versions, the difficulty in understanding what it was supposed to do
both for the overall goal of the series and the individual changes, and
the fact that several people have found bugs for use cases other than
your own (all the way up to removing non-DT support) are all saying that
this is something that needs careful review and also making that review
difficult.

Code review is an important part of the process, we need people to work
to make that review easy, address review comments and allow a reasonable
time for the review to happen (something that's obviously going to be
quicker with submissions that are easier to review).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/81a984f1/attachment.sig>
