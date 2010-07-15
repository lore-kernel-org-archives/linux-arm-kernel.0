From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Thu, 15 Jul 2010 13:49:28 +0200
Subject: [PATCH 1/3] ARM: driver for the character LCD found in ARM
	refdesigns
In-Reply-To: <20100715102237.GI26212@n2100.arm.linux.org.uk>
References: <1278429668-4564-1-git-send-email-triad@df.lth.se>
	<20100715102237.GI26212@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinxE6hbgVWqvxen6yDNM1VLgK2DFnMyN_o_zbsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/15 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Jul 06, 2010 at 05:21:08PM +0200, Linus Walleij wrote:

>> This adds a driver for the character LCD found on the ARM Versatile
>> and RealView Platform Baseboards. It doesn't do very much more than
>> display the text "ARM Linux" on the first line and the linux banner
>> on the second line, but that's still useful.
>
> I think the only questionable thing on this is the location of the
> driver. ?As we now have plat-versatile for the shared stuff between
> integrator, verastile, realview and versatile express, maybe it'd
> make more sense to be in plat-versatile?

OK I can move it there.

> Or maybe drivers/platform/arm/ (to avoid Linus' complaint about
> drivers under arch/ ?)

Creating that for a single driver seems weird, I could just as well
create drivers/lcd for all LCDs in that case. But there is another
LCD-like driver for a USB-connected LCD under drivers/misc
IIRC, maybe I can make a patch for that as well and let the misc
maintainer decide if he wants it.

Yours,
Linus Walleij
