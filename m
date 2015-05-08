From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Fri, 8 May 2015 20:28:42 +0200 (CEST)
Subject: [1/2] RTC: Add core rtc support for Gemini Soc devices
In-Reply-To: <beaeec189608d669a47cac8ad589ee25@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2694895.MomHLoCaoZ@wuerfel> <alpine.LNX.2.00.1505070455130.32495@T520.local>
 <5043733.xO9lSCKvly@wuerfel> <alpine.LNX.2.00.1505071936170.19877@T520.local>
 <beaeec189608d669a47cac8ad589ee25@advem.lv>
Message-ID: <alpine.LNX.2.00.1505081956480.15607@T520.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

On Fri, 8 May 2015, Roman Yeryomin wrote:

> On 2015-05-07 20:46, Hans Ulli Kroll wrote:
> > Hi
> > 
> > On Thu, 7 May 2015, Arnd Bergmann wrote:
> > 
> > > On Thursday 07 May 2015 05:00:03 Hans Ulli Kroll wrote:
> > > > On Wed, 6 May 2015, Arnd Bergmann wrote:
> > > > > As far as I'm concerned, we should just merge all the patches from
> > > > > http://git.openwrt.org/?p=openwrt.git;a=tree;f=target/linux/gemini/patches-3.18
> > > > >
> > > > > We should also try to find a maintainer that can respond to patches
> > > > > in a timely manner. If Ulli has time for that again, that would be
> > > > > great,
> > > > > otherwise I think we should find someone from OpenWRT to take over.
> > > >
> > > > I'm back in busyness.
> > > > Currently me dev device is right next to me.
> > > > I moved some time ago and haav to find it in some 'hidden' box.
> > > 
> > > Awesome, welcome back!
> > > 
> > > Are you able to look at the patches I mentioned above and submit them
> > > to arm at kernel.org, cc linux-arm-kernel at lists.infradead.org with proper
> > > patch descriptions?
> > > 
> > >  Arnd
> > > 
> > 
> > Already done,
> > RTC driver send.
> > Compilder fix for MACH-RECORD send.
> > Maintainer Update send.
> > 
> > This device is a (very) bad design, to be polite !
> > I think they didn't test this properly.
> > And they fixed some software issues in hardware.
> > To be exact :
> > They switched the IDE channels in hardware, to get around the stupid
> > Sausalito software.
> 
> AFAIK, ide channels are switchable in the driver.

Yes.
But there is a HW switch.
/* Values of IOMUX
 * 26:24 bits is "IDE IO Select"
 * 111:100 - Reserved
 * 011 - ata0 <-> sata0, sata1; bring out ata1
 * 010 - ata1 <-> sata1, sata0; bring out ata0
 * 001 - ata0 <-> sata0, ata1 <-> sata1; bring out ata1
 * 000 - ata0 <-> sata0, ata1 <-> sata1; bring out ata0
*/

This is from an email long time ago, with Paulius Zaleckas who has the 
yoriginal documentation to this SoC.
I hacked some weeks (or months) to get this thing running.

Some HDD are working well, others don't. At this time, this was only one 
manufacturer, who has only the "bad" devices.
Early this year, I got some report from one user. He has two hdd's from 
the same manufacturer. One hdd is working well, the other don't.

At the end of this "session" I've taken this device to some hidden place.
;-)

Ulli
