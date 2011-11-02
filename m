From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 2 Nov 2011 08:46:06 +0100 (CET)
Subject: [RFC 0/5] restart cleanups
In-Reply-To: <1676495226.4381981320219764753.JavaMail.root@zimbra20-e3.priv.proxad.net>
Message-ID: <2088587985.4382541320219966553.JavaMail.root@zimbra20-e3.priv.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- Mail Original -----
De: "Russell King - ARM Linux" <linux@arm.linux.org.uk>
> We do have this problem - mioa701 - which insists on doing things like
> kfree, free_irq, gpio_free in this path, which is a bad idea as it can
True. You mean gsm_exit() and bootstrap_exit() I think.
These were added to free resources in a shutdown. If freeing is pointless,
in a reboot case, and stale resources don't matter, well, we can kill these
2 functions.

> However, we don't know whether removing the code will then prevent it
> rebooting even for a userspace-invoked reboot.  We need feedback from
> the platform maintainer for that (added Philipp and Robert in the
> hope one of them can answer this - and maybe send a patch to fix it.)
I'll try to test the patch serie this evening after my daywork,
and give feedback.

The main facts of mioa701 board regarding halting/rebooting:
 - watchdog reset kills RTC time
 - there is no GPIO reset (which would preserve time, sic ...)
 - mioa701 is based on PXA272 (arm v5)

Cheers.

--
Robert
