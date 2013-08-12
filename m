From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 12 Aug 2013 14:05:51 +0200
Subject: [PATCH 1/3] ARM: dts: mxs: set dcp to "disabled" by default
In-Reply-To: <20130812110523.GD25292@S2101-09.ap.freescale.net>
References: <1375968629-10091-1-git-send-email-LW@KARO-electronics.de>
 <1375968629-10091-2-git-send-email-LW@KARO-electronics.de>
 <20130812110523.GD25292@S2101-09.ap.freescale.net>
Message-ID: <21000.53151.841177.378797@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo writes:
> On Thu, Aug 08, 2013 at 03:30:27PM +0200, Lothar Wa?mann wrote:
> > Reintroduce 'status = "disabled"' for the dcp node that was dropped by
> > commit 519d8b1a "Added support for Freescale's DCP co-processor".
> 
> For IP blocks that do not have pins to be routed on boards, it should be
> fine to have it enabled in <soc>.dtsi.
> 
That means that when a new driver is added, it will start wasting
resources on all board using that SoC unless the board maintainers
explicitly disable that driver in DTB.

I would prefer things to be the other way:
New drivers (no matter whether for chip-internal or external hardware)
should require to be explicitly enabled for those platforms on which
they are being used.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
