From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 21 Mar 2017 09:05:51 +0100
Subject: [PATCH 2/2] spi: imx: fix use of native chip-selects with
 devicetree
In-Reply-To: <4a8449d9-cc38-d642-0853-246f46ee7059@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
 <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
 <4a8449d9-cc38-d642-0853-246f46ee7059@linux-m68k.org>
Message-ID: <20170321080551.ie4xm5hr3fki365s@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 21, 2017 at 12:05:20PM +1000, Greg Ungerer wrote:
> On 20/03/17 23:22, Vladimir Zapolskiy wrote:
> > For that type of bindings locally I have a hackish spi-imx driver change,
> > which supports this option, but I'm unsure if it is universal enough.
> 
> Do you mean supporting no cs-gpios tag?
> That would be nice, but it would seem not many users of this are
> using native chip selects. 

The reason for this is that the native chip selects are less flexible
than gpios because you cannot control when they deassert. IIRC they do
it too much for some chips. So the only reason to stick to them is that
on some SoCs not all pins have a GPIO function. Not sure if transfer
speed is another reason, but I would expect that the gain isn't that
big.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
