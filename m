From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jan 2010 21:05:03 +0000
Subject: Question: __ARM_EABI__
In-Reply-To: <BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE190902089C63@mi8nycmail19.Mi8.com>
	<19278.11469.95923.629825@pilspetsen.it.uu.se>
	<BD79186B4FD85F4B8E60E381CAEE190902089C95@mi8nycmail19.Mi8.com>
Message-ID: <20100113210503.GG28292@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 03:57:12PM -0500, H Hartley Sweeten wrote:
> On Wednesday, January 13, 2010 1:28 PM, Mikael Pettersson wrote:
> > H Hartley Sweeten writes:
> >> Hello all,
> >> 
> >> The following commit added a check for __ARM_EABI__ and raises a
> >> warning if it's not defined.
> >> 
> >> commit 6603a4fd5195a004dec5f9568e38ff76bae630c1
> >> Author: Claudio Scordino <claudio@evidence.eu.com>
> >> Date:   Fri Oct 30 12:06:05 2009 +0100
> >> 
> >>     ARM: 5776/1: Check compiler version and EABI support when adding ARM unwind support.
> >> 
> >> Where is this definition supposed to come from?
> >
> > The C compiler used to compile the kernel.
> 
> OK.  I'm using a gcc-4.3.2 compiler created with crosstool-NG:

4.3.2 doesn't generate proper unwind information, so the warning is
actually correct - it doesn't support EABI unwind information.
