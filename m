From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sun, 18 Nov 2012 15:36:32 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2Ml0gTWlzYzogQVJNX0NIQVJfTENEOiBQZXJtaXQg?=
 =?UTF-8?B?dGhlIHVzZSBvZiBhIGRyaXZlciBvbiBhbnkgQVJNIG1hY2hpbmU=?=
In-Reply-To: <20121118111016.GS3290@n2100.arm.linux.org.uk>
References: <1353236200-11435-1-git-send-email-shc_work@mail.ru>
 <20121118111016.GS3290@n2100.arm.linux.org.uk>
Message-ID: <1353238592.871034755@f294.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > arm-charlcd driver can be used on any ARM machine, so dependency of
> > PLAT_VERSATILE is removed.
> 
> This needs a better explanation.  We know that it's used on ARMs
> reference boards.  Which other platforms will be making use of this
> driver?  Do these other boards implement the same interface, including
> the presence of the interrupt?
LCD controller do not have interrupt output. In driver interrupt is optional
and used for delay operations, since controller is too slow. Probably, as
you say, it used by additional onboard FPGA for a delay read/write operations
on fast CPU bus and/or generate clock. All other controller signals are normal
CPU-bus signals.

> I'd need to re-read the specs, but I think that the interface this
> driver uses is provided by ARMs FPGA rather than the LCD module itself,
> and re-use of this driver would need that IP to be implemented elsewhere.
Commands in the driver - is a controller commands, so it can be reused by
other machines. For example, I want to reuse this driver for clps711x.

Detail description of controller present on wiki:
http://en.wikipedia.org/wiki/HD44780_Character_LCD

---
