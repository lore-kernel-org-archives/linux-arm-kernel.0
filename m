From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jul 2010 10:37:20 +0900
Subject: ARM Machine SoC I/O setup and PAD initialization code
In-Reply-To: <20100723210347.GO20855@pengutronix.de>
References: <201007211029.29529.david.jander@protonic.nl>
	<201007221531.58744.david.jander@protonic.nl>
	<20100722142043.GK4737@rakim.wolfsonmicro.main>
	<201007231218.07379.david.jander@protonic.nl>
	<20100723141712.GC12300@rakim.wolfsonmicro.main>
	<61396.213.84.91.226.1279910330.squirrel@protonic.xs4all.nl>
	<20100723210347.GO20855@pengutronix.de>
Message-ID: <AANLkTin=uThThNaUxCP4qEJjO2TYMzpHfmZ6jLokQxCD@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 24, 2010 at 6:03 AM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
> kexec is a good idea only in theory. Last time we tried it, it needed
> something like 6 s additional boot time. Inacceptable - we bring Qt
> based GUI systems into the application in 6 s, and automotive systems
> into userspace in 336 ms. Not to mention that the first kernel needs to
> be brought up as well.

I disagree with your "in theory only" stamp on kexec. I've used kexec
for rebooting and crash dumping on i386, x86_64, ia64, ARM and SH. 10
years ago before kexec I booted Linux from Linux on Powerpc using the
"relf" kernel module. I know that closed-source RTOS has booted
themselves for ages, look at vxWorks and/or pSOS if you happen to be
interested in history.

The two presentations pointed out earlier in this thread clearly show
how to build kexec based boot loaders which boot in one second. The
overhead of kexec itself is almost nothing. I'm sure you can discuss
the details of the kexec implementation with Eric Biederman if you'd
like.

That aside, the 6 s number looks familiar from earlier Barebox
presentations that I've eyed through before. When did you test it? Do
you remember what platform and which kernel version? Are you using a
full Gnome desktop in your boot loader? =)

I'm sure there still are valid reasons why people chose to duplicate
driver development though traditional boot loaders like Barebox or
U-boot. One valid reason may be size of the boot loader, another may
be speed.

The 6 s difference you point out is just strange IMO. I'm not sure
what you are booting with your boot loader. Is it a Linux kernel? If
so, are you trying to say that kexec itself is slow or that the kernel
is slow?
