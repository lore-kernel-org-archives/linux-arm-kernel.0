From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 25 Dec 2010 11:04:11 -0500 (EST)
Subject: [PATCH 1/7] msm: io: I/O register definitions for MSM8960
In-Reply-To: <201012241429.28901.arnd@arndb.de>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<201012152337.19475.arnd@arndb.de>
	<20101217001658.GA5880@huya.qualcomm.com>
	<201012241429.28901.arnd@arndb.de>
Message-ID: <alpine.LFD.2.00.1012251100340.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Dec 2010, Arnd Bergmann wrote:

> On Friday 17 December 2010, David Brown wrote:
> > I'm not sure really what to do about PHYS_OFFSET.  This is kind of the
> > big thing that has kept us so far from making our SOCs multiply
> > selectable.  I could move this into a Kconfig option, but it would
> > still need to be selected by the SOC.  It is unfortunate that most of
> > our SOCs have different enough memory configurations that these are
> > mostly different.  Even 8960/8660 will probably have future variants
> > that are at different addresses.
> 
> I think there are people working on relocatable kernels already,
> and we definitely need this for the other work in progress of
> doing kernel binaries that work across different SoC families,
> as well as for doing a single kernel that can be used both for
> booting the system and for kdump.
> 
> You don't need to worry about PHYS_OFFSET at the platform level,
> we'll get there in a few months for all ARM platforms.

... or in a few days even.  I'm currently working on the patch making 
PHYS_OFFSET patched into the kernel at run time.  I'm currently looking 
at what is needed to make it work also with Thumb2.


Nicolas
