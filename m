From: mzoran@crowfest.net (Michael Zoran)
Date: Thu, 02 Feb 2017 02:16:09 -0800
Subject: [RESENT PATCH] ARM: bcm2835: Add devicetree for the Raspberry
 Pi 3, for arm (32)
In-Reply-To: <3b3ffeb9-6e92-114c-8fdc-9586bdc68373@i2se.com>
References: <1484845444-4617-1-git-send-email-kraxel@redhat.com>
 <87fukcgsqp.fsf@eliezer.anholt.net> <878tpqki0k.fsf@eliezer.anholt.net>
 <1485944672.1076.50.camel@redhat.com> <1485951653.1076.54.camel@redhat.com>
 <1486024672.11636.1.camel@crowfest.net>
 <3b3ffeb9-6e92-114c-8fdc-9586bdc68373@i2se.com>
Message-ID: <1486030569.18291.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-02-02 at 10:50 +0100, Stefan Wahren wrote:
> Am 02.02.2017 um 09:37 schrieb Michael Zoran:
> > This is actually a problem I had to deal with way in the begging of
> > ARM64.? What was done in the github tree was to have the one of the
> > DTS
> > ?? files(in this case 64) #include the 32 bit dts.? That way it's
> > not
> > needed to have the symbolic link and install should work.
> > 
> > I know it's ulgy, but it works...
> > 
> > Take a look at:
> > https://github.com/raspberrypi/linux/blob/rpi-4.10.y/arch/arm64/boo
> > t/dt
> > s/broadcom/bcm2710-rpi-3-b.dts
> > 
> > Here is what the file contains:
> > #define RPI364
> > 
> > #include "../../../../arm/boot/dts/bcm2710-rpi-3-b.dts"
> > 
> > 
> > 
> 
> This do not work in the context of the split device-tree repository
> [0]?
> (where the directory structure differs).
> 
> [0]?
> https://git.kernel.org/cgit/linux/kernel/git/devicetree/devicetree-re
> basing.git/

Well, two other options would be to simply duplicate the device tree
files. I know that's a pain...

The other option is choose one or the other(arm64 vs. arm32), I would
guess pick arm32.  It works...  And at this time, arm64 doesn't have a
whole bunch of benefit on the RPI 3.  Perhaps maybe a RPI 4 will come
out someday and we will see more of a gain.
 
