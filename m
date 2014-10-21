From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Oct 2014 16:17:02 +0200
Subject: [PATCH] arm: dts: add initial support for TBS2910 Matrix ARM
 mini PC
In-Reply-To: <54464BA7.9030001@gmail.com>
References: <1413635236-3825-1-git-send-email-smoch@web.de>
 <54460DD5.5010908@gmail.com> <54464A3A.2070003@web.de>
 <54464BA7.9030001@gmail.com>
Message-ID: <20141021141702.GQ14443@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 21, 2014 at 02:03:51PM +0200, Sebastian Hesselbarth wrote:
> On 21.10.2014 13:57, S?ren Moch wrote:
> >>>+/ {
> >>>+    model = "TBS2910 Matrix ARM mini PC";
> >>>+    compatible = "tbs,imx6q-tbs2910", "fsl,imx6q";
> >>
> >>[...]
> >>Also, board compatible should only be "tbs,tbs2910".
> >
> >Similar boards use e.g.
> >     compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
> >     compatible = "udoo,imx6q-udoo", "fsl,imx6q";
> >     compatible = "wand,imx6q-wandboard", "fsl,imx6q";
> >
> >So is it really better to use only "tbs,tbs2910" here?
> 
> Hmm, having the SoC name again in the board compatible seems
> odd to me, e.g. we have "google,chromecast" without the SoC
> name in it.

No. My vanilla 3.17 kernel has this:

arch/arm/boot/dts/berlin2cd-google-chromecast.dts:17:   compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";

> 
> Anyway, it is just a compatible and if it is common for imx-
> based boards or Shawn/Sascha like to have it this way you
> should stick with that, of course.

It has to be that way, because the kernel matches to "marvell,berlin",
not the board name. Otherwise we would have to compile in all board
compatible strings into the kernel or the kernel would refuse to start.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
