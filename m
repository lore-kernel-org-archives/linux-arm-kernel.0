From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 21:13:31 +0200
Subject: Link failures due to __bug_table in current -next
In-Reply-To: <20110920185121.GA17169@n2100.arm.linux.org.uk>
References: <20110919120954.GA20314@opensource.wolfsonmicro.com>
	<CAPnjgZ2-Ttmoa8zwSVqL70vXDoJv=-Z2XyVBuTi-bm4-0c6E-Q@mail.gmail.com>
	<20110920185121.GA17169@n2100.arm.linux.org.uk>
Message-ID: <201109202113.31829.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Russell King - ARM Linux wrote:
> On Tue, Sep 20, 2011 at 10:00:06AM -0700, Simon Glass wrote:
>
> That was the same thought for the SMP alternatives problem - I think
> Nicolas proposed that there should be some way that the linker can
> do sections based on the current section name.  That'd allow us to
> have .alt.smp.exit.text and __bug_table.exit.text etc.

Right. also *.pv_table, which is another section that has this problem.

> > In any case, it sounds from the next email in this thread that your
> > patch has fixed the problem! So, where does that leave us?
> 
> I think we apply the patch, which resolves the problem, and point it
> out to whoever looks after the asm-generic/vmlinux.lds.S file (Arnd?
> I'll check when I re-dock the laptop later this evening.)  I suspect
> Arnd is already reading some of these messages...

While I'm looking after asm-generic in general, I tend to just ack
the patches and let them go through someone else's tree most of
the time, because there are usually dependencies and the number of
patches for asm-generic is not high enough to require a tree on
its own.

For the vmlinux.lds.h file, I think the people that have contributed
to it the most are Sam Ravnborg and Tim Abbott (added to Cc).
The best way to get the right people to hear about it should be
to send the patch to linux-arch with these two on Cc.

	Arnd
