From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 11:55:00 +0100
Subject: [PATCH 06/10] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
In-Reply-To: <201205091110.15224.heiko@sntech.de>
References: <1336514694-22393-1-git-send-email-thomas.abraham@linaro.org>
 <1336514694-22393-7-git-send-email-thomas.abraham@linaro.org>
 <20120509085617.GB28702@sirena.org.uk>
 <201205091110.15224.heiko@sntech.de>
Message-ID: <20120509105500.GG3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 11:10:14AM +0200, Heiko St?bner wrote:

> Similar to the adc and rtc driver, all Samsung platforms reuse a common 
> platform-device definition for the s3c64xx-spi and simply will set the correct 
> name when the machine type is determined during boot.

Right, that doesn't mean this is a great way of doing things, though -
it's been a frequent source of errors in the past and is painful to
debug as the data structures get rewritten during boot which is a bit of
a surprise.

> The alternative is creating a mulitude of platform devices for each possible 
> machine type using this driver.

Yes, that's the normal way of handling this and is actually what the
code was originally doing - there's a bunch of ifdefed devices in
plat-samsung/devs.c.  You usually have to do this anyway as the IPs move
about so the resources need changing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/907f697e/attachment-0001.sig>
