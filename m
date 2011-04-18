From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Apr 2011 23:31:08 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <34EB51B7-AF3B-4DCE-A402-953B2DBC0474@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418115903.GB9462@sirena.org.uk>
	<34EB51B7-AF3B-4DCE-A402-953B2DBC0474@niasdigital.com>
Message-ID: <20110418223108.GA5935@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 08:16:12AM +1000, Ben Nizette wrote:
> On 18/04/2011, at 9:59 PM, Mark Brown wrote:

> > Even if it ends up being the board code using these APIs it seems
> > sensible to have a standard API that GPIO drivers can use to expose the
> > functionality.  This will help with getting control into code Linux owns
> > (since people don't have to implement custom APIs) and will mean we can
> > do things like add control of this for device tree based boards.

> Oh I'm all for platform-specific libraries abstracting this away from the
> board code if that helps, that's certainly the way that, eg, AVR32 does it.
> It just doesn't make sense to me to bounce from the board code in to
> 'generic' gpio code then back to platform-specific implementations when
> you could cut out the middle man.

We have cross platform abstractions for lots of things - device tree,
which I mentioned, is the obvious example - and many of the GPIO
controllers are themselves cross platform as they're for off-SoC chips.
