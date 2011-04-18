From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Apr 2011 12:59:03 +0100
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
Message-ID: <20110418115903.GB9462@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 06:50:12PM +1000, Ben Nizette wrote:

Please fix your MUA to word wrap within paragraphs; I've reflowed your
text for legibility.

> Still my question stands, where is the driver ever better placed to
> make these calls than the board code?

Even if it ends up being the board code using these APIs it seems
sensible to have a standard API that GPIO drivers can use to expose the
functionality.  This will help with getting control into code Linux owns
(since people don't have to implement custom APIs) and will mean we can
do things like add control of this for device tree based boards.
