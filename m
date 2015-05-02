From: ijc@hellion.org.uk (Ian Campbell)
Date: Sat, 02 May 2015 17:21:35 +0100
Subject: Bug#782364: linux-image-3.16.0-4-armmp: please configure
 drivers for both Cubox i4pro real time clocks
In-Reply-To: <20150502161226.GS12732@n2100.arm.linux.org.uk>
References: <20150410232854.23367.58862.reportbug@cube.rcthomas.org>
 <1428710930.29665.17.camel@decadent.org.uk>
 <20150429085705.GG12732@n2100.arm.linux.org.uk>
 <1430582464.15640.186.camel@hellion.org.uk>
 <20150502161226.GS12732@n2100.arm.linux.org.uk>
Message-ID: <1430583695.15640.190.camel@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2015-05-02 at 17:12 +0100, Russell King - ARM Linux wrote:
> On Sat, May 02, 2015 at 05:01:04PM +0100, Ian Campbell wrote:
> > So is your advice for a multi platform kernel supporting all Cubox
> > devices to just enable both and to sort out any syncing/naming etc in
> > userspace?
> 
> I don't see a problem locally, because I have both built in to my kernel:
> 
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 1 port detected
> mousedev: PS/2 mouse device common for all mice
> rtc-pcf8523 0-0068: rtc core: registered rtc-pcf8523 as rtc0
> snvs_rtc 20cc034.snvs-rtc-lp: rtc core: registered 20cc034.snvs-rtc-lp as rtc1
> i2c /dev entries driver
> 
> and so the battery-backed one gets the primary RTC device.

We typically build RTCs statically (for this sort of reason) so it seems
like the right thing for us to do here is to build both in.

Does the battery backed one automatically get synced to the time based
wake up one too, or is that in userspace?

What I wasn't sure about was if both were =y whether the init order was
guaranteed across kernel versions etc. It sounds like you are saying it
will Just Work if we build both in, which is what I was hoping for.

> I guess the problem comes when you have them as modules, and then systemd
> or udev, or whatever init daemon flavour you're using can load the modules
> in a random order (or even in parallel) so you've no idea which RTC is
> which.

Right. 

> Yes, I believe this is a userspace problem, because:

[...]

Yes, ack.

Thanks,
Ian.
