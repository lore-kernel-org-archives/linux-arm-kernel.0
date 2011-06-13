From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Jun 2011 02:59:31 -0700
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612155940.GM10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
	<20110612145751.GA4013@ponder.secretlab.ca>
	<20110612151931.GK10283@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1106121145570.2142@xanadu.home>
	<20110612155940.GM10283@n2100.arm.linux.org.uk>
Message-ID: <20110613095931.GB10951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110612 08:55]:
> 
> I don't see this as a sustainable way forward.  If we're going to move a
> particular SoC over to DT, we need to move the entire SoC over.  We can't
> do this half-heartedly.

Agreed. In addition to ATAGs, we need to also consider the large chunks
of data in kernel that Linus originally complained about. We absolutely don't
want to have the same in two places both in .dts files and in platform data
for things like mux, clocks, hwmod data etc.

So we need to make sure the DT append support works transparently for
existing bootloaders so we can just drop the the old data instead of
keeping it around.

Regards,

Tony
