From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 21 Jan 2014 07:59:22 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140120151152.GE15937@n2100.arm.linux.org.uk>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
 <20140120150902.207b9d66@ipc1.ka-ro>
 <20140120151152.GE15937@n2100.arm.linux.org.uk>
Message-ID: <20140121075922.2a83e076@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux wrote:
> On Mon, Jan 20, 2014 at 03:09:02PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Russell King - ARM Linux wrote:
> > > On Mon, Jan 20, 2014 at 12:36:27PM +0100, Lothar Wa?mann wrote:
> > > > In case user space firmware loading support (CONFIG_FW_LOADER) is
> > > > enabled, this message may still be inadequate, since the firmware may
> > > > very well be loaded lateron.
> > > 
> > > I haven't worked out whether that's actually possible - I saw no way to
> > > re-trigger the firmware request, and once the firmware request expires,
> > > there seems to be no way for userspace to say "okay, the firmware is now
> > > available, please load it".
> > > 
> > I can confirm that it does work, since I'm using it.
> > I have the following in my /etc/init.d/mdev.sh script:
> > |        [ "$VERBOSE" = no ] || echo -n "Triggering firmware load"
> > |        for dir in $(find /sys/class/firmware/ -type l);do
> > |            echo add > "$dir/uevent"
> > |        done
> 
> I can't check on iMX6 at the moment, but I did look in that directory
> after the iMX6 SDMA reported that it hadn't found any firmware, and
> it was empty apart from the "timeout" file.
> 
The file is automatically removed after the timeout has expired (or
the frimware has been loaded).
Thus you must check for it within the timeout period during boot.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
