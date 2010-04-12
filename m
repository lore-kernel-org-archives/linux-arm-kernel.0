From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:15:06 +0100
Subject: [PATCH] arm: ARCH_REQUIRE_GPIOLIB selects GENERIC_GPIO
In-Reply-To: <0D753D10438DA54287A00B0270842697636D4B70AD@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B0270842697636A7E9494@AUSP01VMBX24.collaborationhost.net>
	<20100412184904.GG3048@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636D4B70AD@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20100412191506.GL3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 02:01:17PM -0500, H Hartley Sweeten wrote:
> On Monday, April 12, 2010 11:49 AM, Russell King wrote:
> > On Thu, Apr 01, 2010 at 05:32:18PM -0500, H Hartley Sweeten wrote:
> >> The ARCH_REQUIRE_GPIOLIB config option will select GPIOLIB which
> >> in turn will select GENERIC_GPIO.  Because of this, there is no
> >> reason to do the select GENERIC_GPIO in arch/arm/Kconfig for the
> >> architectures that have ARCH_REQUIRE_GPIOLIB.
> >
> > This kind of patch normally causes regular merge conflicts, which
> > historically have caused a repeated number of headaches - there's
> > a similar patch for GENERIC_TIME which is pending.
> >
> > I suggest waiting until we're closer to the merge window than we
> > are at present; I'll bring my devel stuff to a freeze state before
> > hand so we can get these two patches merged - maybe around the
> > -rc7 release.
> >
> > Please ping me closer to that.
> 
> Will do.
> 
> I just wanted to get this out there to make sure nobody saw any issues.
> 
> I will hold this until around -rc7 as you requested and just collect any
> Ack's, etc., that show up.  Eric Miao has already sent an Acked-by that
> I will add then.

Also please keep an eye for any new places in -next where GENERIC_GPIO
is selected as well as ARCH_REQUIRE_GPIOLIB - we're likely to see new
platforms being added which may continue the old mistake.
