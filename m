From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 01 May 2015 21:40:40 +0200
Subject: [PATCH 2/2] misc: Add initial Digital Timing Engine (DTE) driver
 for cygnus
In-Reply-To: <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
References: <1429744923-2007-1-git-send-email-jonathar@broadcom.com>
 <5543CD73.2030902@broadcom.com> <20150501203004.3add2c95@lxorguk.ukuu.org.uk>
Message-ID: <9193036.7UYD2OGJHk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 May 2015 20:30:04 One Thousand Gnomes wrote:
> 
> > channel control, unless I'm missing something. If people are flexible
> > with extending that I could propose something. Let me know which way you
> > prefer to go. Thanks.
> 
> I would strongly favour fixing PTP to do this right. Otherwise we will
> have 2 or 3 adhoc drivers, then end up moving them to PTP and then end up
> dealing with the compat mess.

Agreed. I was hoping that there was already a subsystem in the kernel that
could be extended to work with this driver. If all that is needed is to
pass more fields of the existing timex to ptp drivers, that should be
fairly easy to do.

We also have some padding bytes available in struct timex in case some
extra data needs to be passed, or we could add another clock_* system call
if it's absolutely required to have another entry into the driver, and
connect that through struct k_clock and posix_clock_operations(). I would
hope we don't even need that.

	Arnd
