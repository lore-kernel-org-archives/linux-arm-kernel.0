From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 3 May 2011 17:08:54 +0100
Subject: [PATCH] ARM: Include Makefile.boot only when it exists
In-Reply-To: <20110429134746.GP5126@n2100.arm.linux.org.uk>
References: <1303103976-4922-1-git-send-email-eric.y.miao@gmail.com>
	<20110420083258.GB1517@S2100-06.ap.freescale.net>
	<BANLkTiknesdF7cMZ=RGJAh75aW_wRpyj-w@mail.gmail.com>
	<20110428152735.GU17290@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104281925500.24613@xanadu.home>
	<20110429075346.GU17290@n2100.arm.linux.org.uk>
	<20110429133223.GB11885@S2100-06.ap.freescale.net>
	<20110429134746.GP5126@n2100.arm.linux.org.uk>
Message-ID: <20110503160854.GE2893@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 02:47:46PM +0100, Russell King - ARM Linux wrote:

> http://lists.arm.linux.org.uk/lurker/message/20110330.192132.f01e0669.en.html

> and understand Linus' position on this:

>    Something needs to be done. A small part is to make sure the source
>    code is more hierarchical, so that we don't have those crazy shared
>    data-files that are ugly as hell and get conflicts because different
>    boards all think they need to care.

> || But the larger problem is that somebody really REALLY needs to think   ||
> || about how to get those crazy board details out of the kernel entirely. ||
> || Having per-board drivers for real hardware is sane - having to have    ||
> || per-board detail files for clock chips is just crazy. Split off that   ||
> || thing a "Linux ARM second-stage bootloader" project that has the       ||
> || per-board tables or something. Don't pollute the main kernel with      ||
> || crazy details like this.                                               ||

> That is pretty clear to me that Linus does _not_ want these kinds of
> details in the main kernel source _at_ _all_.  No matter how they're
> represented, be it .c file or .dts file.

Reading this he's talking a lot about "per-board" things, but what he's
talking about is things which should be done once per chip.  There does
seem to be some room for discussion here, "actually what you're seeing
here is X, here's why we don't want to start doing Y" type things.
