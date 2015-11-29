From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Nov 2015 18:09:39 +0000
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr>
References: <20150713131902.GH26485@atomide.com>
 <20151127132722.GA30871@n2100.arm.linux.org.uk>
 <20151127195148.GB30871@n2100.arm.linux.org.uk>
 <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
 <20151128123328.GC30871@n2100.arm.linux.org.uk>
 <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr>
Message-ID: <20151129180939.GE30871@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2015 at 12:34:23PM -0500, Nicolas Pitre wrote:
> Good. And Arnd likes the idea too. So we might be converging at last 
> which is a good thing.

I disagree with the idea that there is convergence.  There might be
convergence towards an idea, but... Here's a mail extract, from July
7th, from earlier in this very thread:

Pali:
> Me:
> > Are the ATAGs at a fixed address on the N900?
> 
> Yes, in board-rx51.c is:
> 
> .atag_offset    = 0x100
> 
> and Nokia Bootloader (proprietary) store them to that address.
> 
> > Can that be handled in
> > some kind of legacy file for the N900 which calls save_atags() on it, so
> > we don't end up introducing yet more stuff that we have to maintain into
> > the distant future?  If not, what about copying a known working atag
> > structure into a legacy file for the N900?
> >
> 
> I already asked question if it is possible to read ATAGs from DT booted
> kernel. And somebody (do not remember who) wrote to ML, that it is not
> possible and it can be done in that uncompress code.

So you're converging on an idea that has already been rejected.  That's
not a good thing, IMHO.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
