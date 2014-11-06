From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 6 Nov 2014 13:47:11 +0100
Subject: N900 modem support in 3.18-rc1
In-Reply-To: <20141105234555.GA7097@earth.universe>
References: <20141104205117.GA17606@amd> <201411052137.31452@pali>
 <20141105203918.GA29199@amd> <201411052206.05379@pali>
 <20141105220359.GA32052@amd> <20141105234555.GA7097@earth.universe>
Message-ID: <20141106124711.GA26944@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> On Wed, Nov 05, 2014 at 11:03:59PM +0100, Pavel Machek wrote:
> > > Maybe you need to enable modem?
> > > 
> > > This is n900 init sequence from script: nokia-n900-configs.sh
> > 
> > From the dts, it looks like this should somehow work without this.
> 
> Right :) The n900-modem driver will take care of this if the "pm"
> parameter is set to 1 (which should be the default).

I actually had pm=0 on the command line, but I removed it now, and no
change:

root at n900:~# find /sys/bus/hsi/devices/n900-modem/
/sys/bus/hsi/devices/n900-modem/
/sys/bus/hsi/devices/n900-modem/power
/sys/bus/hsi/devices/n900-modem/power/control
/sys/bus/hsi/devices/n900-modem/power/runtime_active_time
/sys/bus/hsi/devices/n900-modem/power/autosuspend_delay_ms
/sys/bus/hsi/devices/n900-modem/power/runtime_status
/sys/bus/hsi/devices/n900-modem/power/runtime_suspended_time
/sys/bus/hsi/devices/n900-modem/modalias
/sys/bus/hsi/devices/n900-modem/driver
/sys/bus/hsi/devices/n900-modem/subsystem
/sys/bus/hsi/devices/n900-modem/uevent
root at n900:~# cat /proc/cmdline 
root=/dev/nfs nfsroot=192.168.1.6:/srv/nfs/n900 rw
ip=192.168.1.8::192.168.1.6:255.255.255.192::usb0:  no-omap-wd
no-ext-wd console=tty0
root at n900:~# 

Let me try with explicit =1. .. aha, that helps. Thanks!

Do you have an example client that can talk to ofonod?

What is needed to get voice calls to work?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
