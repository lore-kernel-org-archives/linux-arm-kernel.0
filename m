From: tony@atomide.com (Tony Lindgren)
Date: Mon, 20 Oct 2014 09:45:42 -0700
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141020130855.GA1067@amd>
References: <20141019090107.GA19132@amd> <201410191658.45851@pali>
 <20141019205033.GA4738@amd> <201410192300.20625@pali>
 <20141020130855.GA1067@amd>
Message-ID: <20141020164542.GD5192@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pavel Machek <pavel@ucw.cz> [141020 06:10]:
> Hi!
> 
> > My N900 can boot kernel from v3.12-rc5-n900 branch compiled with 
> > arch/arm/configs/rx51_defconfig. Also it can boot full Maemo5 
> > system (with CSSU and some minor system changes) and usb network 
> > via g_nokia.ko gadget working fine...
> > 
> > So if it does not working for you then kernel usb subsystem could 
> > have problems with using gadgets directly from zimage.
> 
> After some hand-bisecting and real-bisecting, I found two commits that
> cause problems for 3.13: With these reverted, I get usb networking
> back in 3.13 on nokia n900.
> 
> (Pali, if you revert these, you should get working usb networking in
> your 3.13 branch, too.)
> 
> Any ideas?

Hmm maybe check if current stable kernels work for you without
reverting anything ? Few weeks ago I did the the following two fixes
with cc stable v3.13+:

96be39ab34b7 usb: phy: twl4030-usb: Fix regressions to runtime PM on omaps
85601b8d81e2 usb: phy: twl4030-usb: Fix lost interrupts after ID pin goes down

Regards,

Tony 
