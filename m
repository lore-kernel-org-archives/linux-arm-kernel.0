From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jan 2014 14:41:30 +0000
Subject: [PATCH 19/19] [INCOMPLETE] ARM: make return_address available
 for ARM_UNWIND
In-Reply-To: <201401071533.35309.arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <20130128125023.GA2027@linaro.org>
 <CA+KhAHYvbxANa84FMDVV96udwhif2P2_XirPhWVWTKy_8iK72A@mail.gmail.com>
 <201401071533.35309.arnd@arndb.de>
Message-ID: <20140107144130.GJ27432@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:33:34PM +0100, Arnd Bergmann wrote:
> On Tuesday 29 January 2013, Keun-O Park wrote:
> > On Mon, Jan 28, 2013 at 9:50 PM, Dave Martin <dave.martin@linaro.org> wrote:
> > > On Mon, Jan 28, 2013 at 11:33:11AM +0900, Keun-O Park wrote:
> > >> Hello guys,
> > >>
> > >> Could you please review the patch of fixing bug first of returning
> > >> wrong address when using frame pointer?
> > >> I am wondering if the first patch is not delivered to the mailing.
> > >
> > > I posted a similar patch to alkml a couple of months ago, but I got
> > > no response and it looks like I forgot about it.
> > >
> > > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129381.html
> > 
> > Yes, same except initialization of data.addr. :)
> > This means there might be no one interested in using
> > ftrace-irqsoff/premptoff in ARM during a couple of months?
> 
> 
> It's been almost a year since we last discussed the patches that were
> posted by Dave and sahara, but nothing has changed in the mainline kernel.
> 
> Any chance that someone could be motivated to pick this work up again
> and finally fix return_address().

I thought that we had _actively_ decided that we would not use the
unwinder for these paths - that it was too expensive for these paths,
and you had to use frame pointers instead.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
