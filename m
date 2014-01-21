From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Tue, 21 Jan 2014 14:36:56 +0100
Subject: [PATCH v2] dma: imx-sdma: clarify firmare not found warning
In-Reply-To: <20140121115706.GT15937@n2100.arm.linux.org.uk>
References: <1390212438-6855-1-git-send-email-s.hauer@pengutronix.de>
 <20140120122840.36520f37@ipc1.ka-ro>
 <20140120123627.1147f252@ipc1.ka-ro>
 <20140120123849.GC15937@n2100.arm.linux.org.uk>
 <20140120150902.207b9d66@ipc1.ka-ro>
 <20140120151152.GE15937@n2100.arm.linux.org.uk>
 <20140121075922.2a83e076@ipc1.ka-ro>
 <20140121110107.GS15937@n2100.arm.linux.org.uk>
 <20140121125200.6b1e96bd@ipc1.ka-ro>
 <20140121115706.GT15937@n2100.arm.linux.org.uk>
Message-ID: <20140121143656.3c0b96c0@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux wrote:
> On Tue, Jan 21, 2014 at 12:52:00PM +0100, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Russell King - ARM Linux wrote:
> > > On Tue, Jan 21, 2014 at 07:59:22AM +0100, Lothar Wa?mann wrote:
> > > > The file is automatically removed after the timeout has expired (or
> > > > the frimware has been loaded).
> > > > Thus you must check for it within the timeout period during boot.
> > > 
> > > ... which is impossible if imx-sdma is built into the kernel - it
> > > expires while the initramfs has only just started running, giving a
> > > very narrow window for userspace to load firmware.
> > > 
> > It works for me, but I'm not using initramfs.
> 
> You can take my email as a report of "it doesn't work for everyone."  The
> *only* way I can get firmware to load is to build imx-sdma as a module.
> Building it in is a hopeless case here.
> 
You could change the timeout from your initramfs as soon as sysfs has
been mounted by writing the number of seconds to
/sys/class/firmware/timeout. A timeout of '0' means 'wait forever' which
should be long enough for any boot case. ;)


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
