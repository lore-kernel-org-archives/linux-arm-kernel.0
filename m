From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Apr 2010 16:56:13 +0100
Subject: Query: ARM Cortex A9: Is invalidating L1 data cache mandatory
	before usage
In-Reply-To: <j2nb0a4007f1004180843qdc3fc56bl418010257119d8e9@mail.gmail.com>
References: <4BC985BD.8040704@st.com>
	<20100417181457.GA24299@n2100.arm.linux.org.uk>
	<j2nb0a4007f1004180843qdc3fc56bl418010257119d8e9@mail.gmail.com>
Message-ID: <20100418155613.GC15452@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 18, 2010 at 09:13:55PM +0530, shiraz hashim wrote:
> On Sat, Apr 17, 2010 at 11:44 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, Apr 17, 2010 at 03:26:13PM +0530, Shiraz HASHIM wrote:
> >> Hello,
> >>
> >> I am trying to port Linux on ARM Cortex A9 based platform and what
> >> I see is that if I don't invalidate the data cache before enabling
> >> and using it (in arch/arm/boot/compressed/head.S) the system crashes.
> >>
> >> I need to do the same for second core before calling secondary_startup.
> >>
> >> Is it normal? Why then other platforms (cortex A9 based) are not doing
> >> this. What am I missing?
> >
> > Yes, it's required. ?See:
> >
> > http://www.arm.linux.org.uk/developer/booting.php
> 
> The only thing which is confusing me is that do we need to invalidate
> the data cache, even if it is disabled in bootloader.

If you don't, the cache will be in an undefined state when it is enabled,
which in turn means that when you enable it, you don't know whether the
instructions you're going to execute come from the cache or from the
memory - and the two may be different.
