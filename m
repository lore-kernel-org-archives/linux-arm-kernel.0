From: will.deacon@arm.com (Will Deacon)
Date: Mon, 9 Jan 2012 23:03:31 +0000
Subject: USB Host port inoperative after kexec on Beagleboard
In-Reply-To: <20120109225403.GB23090@mudshark.cambridge.arm.com>
References: <w4wr90wmrx.wl%peter@chubb.wattle.id.au>
 <20120109225403.GB23090@mudshark.cambridge.arm.com>
Message-ID: <20120109230331.GA23308@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2012 at 10:54:03PM +0000, Will Deacon wrote:
> On Mon, Jan 09, 2012 at 10:09:54PM +0000, Peter Chubb wrote:
> > 
> > Hi Will,
> 
> Hi Peter [adding linux-arm-kernel],

*Actually* adding linux-arm-kernel this time...

> 
> >    Thanks for the fixes to kexec for ARM that went into mainline this
> >    week.  Mostly things work now.
> 
> Great, that's good to hear!
> 
> >    One issue: the USB EHCI port on the (rev C2) beagleboard doesn't
> >    work after a kexec.  During boot after kexec, the host device is
> >    detected and initialised, but nothing plugged in works, even when
> >    everything was working corectly before the kexec.  Das U-boot
> >    must set up something that is then undone during the kexec reboot.
> 
> Ouch. Have you had a chance to look at the u-boot sources to see what it
> does?
> 
> >    I've traced all calls to clk_enable() and clk_disable(), and
> >    everything looks all right --- in particular I can't see 
> >    anything explicitly disabled during kexec that isn't reenabled
> >    during boot of the subsequent kernel.
> > 
> >    Voltages that I can measure look correct on the port.
> > 
> >    Do you have any suggestions as to what else could be wrong?
> 
> I'm afraid I'm not familiar with the Beagleboard, so I can't begin to guess.
> Have you tried re-initialising the host controller in the new kernel
> manually (perhaps my building the driver as a module and {un}loading it a
> few times?). It could be that some hardware state persists across the kexec
> and it just needs resetting.
> 
> Will
