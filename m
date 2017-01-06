From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Jan 2017 08:14:22 -0800
Subject: [PATCH 1/6] ARM: dts: am335x-phycore-som: Update NAND partition
 table
In-Reply-To: <CAHCN7xL2n0qsg61i85o7DczanMH1E=HWhNvqUtTH9UhEVBvd8g@mail.gmail.com>
References: <1483627851-17996-1-git-send-email-t.remmet@phytec.de>
 <1483627851-17996-2-git-send-email-t.remmet@phytec.de>
 <20170105153637.GA4310@atomide.com>
 <20170105171845.GK4310@atomide.com>
 <20170105175619.GA56877@google.com>
 <1483694849.3634.6.camel@phytec.de>
 <20170106160222.GC2630@atomide.com>
 <CAHCN7xL2n0qsg61i85o7DczanMH1E=HWhNvqUtTH9UhEVBvd8g@mail.gmail.com>
Message-ID: <20170106161421.GD2630@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Adam Ford <aford173@gmail.com> [170106 08:06]:
> On Fri, Jan 6, 2017 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Teresa Remmet <t.remmet@phytec.de> [170106 01:28]:
> >> Hello Brian,
> >>
> >> Am Donnerstag, den 05.01.2017, 09:56 -0800 schrieb Brian Norris:
> >> > On Thu, Jan 05, 2017 at 09:18:45AM -0800, Tony Lindgren wrote:
> >> > >
> >> > > * Tony Lindgren <tony@atomide.com> [170105 07:37]:
> >> > > >
> >> > > > * Teresa Remmet <t.remmet@phytec.de> [170105 06:57]:
> >> > > > >
> >> > > > > To improve NAND safety we updated the partition layout.
> >> > > > > Added barebox backup partition and removed kernel and oftree
> >> > > > > partition. They are kept in ubi now.
> >> > > > What about the users with earlier partition tables?
> >> > > >
> >> > > > Please read about "flag day" changes, typically they are not
> >> > > > acceptable.
> >> > > Adding Brian and Adam to Cc. Can you guys come up with some
> >> > > solution on this?
> >> > I don't have much context for this thread, and no I don't plan to
> >> > solve
> >> > your problems for you. But I can provide tips!
> >> >
> >> > >
> >> > > I'm suggesting we leave the kernel nodes empty and let u-boot
> >> > > populate them, so maybe you guys can discuss this on the related
> >> > > lists.
> >> > That's an option. I've worked with platforms that did something like
> >> > this, and that's really one of the only ways you can handle putting
> >> > partition information in the device tree. You're really hamstringing
> >> > yourself when you put all the partition information in the device
> >> > tree.
> >> > And it's just dumb once that gets codified in the kernel source tree.
> >> >
> >>
> >> In our case the bootloader does pass the partition table to the kernel.
> >> So it gets overwritten anyway. This was just more for backup,
> >> if someone uses a different bootloader. But I'm fine with removing the
> >> nand partition table completely from the kernel device tree.
> >> Same with the SPI nor partition table.
> >>
> >> I will send patches for this.
> >
> > OK thanks! Also thank you Brian for your comments.
> >
> 
> Tony - I tested leaving the partition info as-is with the updates from
> the bootloader and it works.  Would you prefer that I match Brian and
> remove the partition table completely, or should I just leave my board
> alone?
> 
> I am good either way.

OK. How about let's remove the partitions from kernel for v4.11 as
clean-up then for cases where the bootloader might change them?

Regards,

Tony
