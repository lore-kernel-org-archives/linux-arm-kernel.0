From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jun 2010 10:41:48 +0300
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <loom.20100604T165709-423@post.gmane.org>
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006040337.10593.marek.vasut@gmail.com>
	<201006040350.36944.marek.vasut@gmail.com>
	<201006040353.35816.marek.vasut@gmail.com>
	<20100604060338.GH6499@atomide.com>
	<loom.20100604T165709-423@post.gmane.org>
Message-ID: <20100607074147.GB15515@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cory Maccarrone <darkstar6262@gmail.com> [100604 18:05]:
> Tony Lindgren <tony <at> atomide.com> writes:
> 
> All the new omap7xx boards I plan to submit in the future should be able to work
> fine in a single defconfig.  That's how I build now with my development tree.
> I'd be perfectly happy to see my htcherald_defconfig get wrapped into a more
> generic omap1_defconfig.

OK. Do you want to take a look at fixing the omap1 entry-macro.S in a similar
way to omap2 entry-macro.S so it works on 7xx too? See the ifdef MULTI_OMAP2
in entry-macro.S. 15xx is ARM925 based, so that's easy to detect. But for
detecting between ARM926 based 7xx and 16xx you would have to use some other
register.
 
> They might even be generic enough that I won't need separate board files for
> them -- I'll have to see when I get to that point.

OK

Regards,

Tony
