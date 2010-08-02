From: p.osciak@samsung.com (Pawel Osciak)
Date: Mon, 02 Aug 2010 14:08:42 +0200
Subject: [PATCH v3 1/8] ARM: Samsung: Add register definitions for	Samsung
	S5P SoC camera interface
In-Reply-To: <20100802105216.GD30670@n2100.arm.linux.org.uk>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
	<1279902083-21250-2-git-send-email-s.nawrocki@samsung.com>
	<00ba01cb2c8f$02fc8480$08f58d80$%kim@samsung.com>
	<003001cb322d$fc976b10$f5c64130$%osciak@samsung.com>
	<20100802105216.GD30670@n2100.arm.linux.org.uk>
Message-ID: <003201cb323b$72f32df0$58d989d0$%osciak@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>On Mon, Aug 02, 2010 at 12:32:20PM +0200, Pawel Osciak wrote:
>> Well, some of them are indeed unused, but it's not an uncommon practice in
>> kernel and might help future developers.
>
>On the other hand, arch/arm is getting soo big that we need to do
>something about this - and one solution is to avoid unnecessary
>definitions that we're not using.
>
>Another good idea is to put definitions along side the drivers which
>they're relevant to - maybe in a local driver-name.h file which
>driver-name.c includes, or maybe even within driver-name.c if they're
>not excessive.  This has the advantage of distributing the "bloat" to
>where its actually used, and means that the driver isn't dependent so
>much on arch/arm or even the SoC itself.
>
>Take a look at arch/arm/mach-vexpress/include/mach/ct-ca9x4.h and
>arch/arm/mach-vexpress/include/mach/motherboard.h - these are the only
>two files which contain platform definitions which are actually used
>for Versatile Express.  Compare that with
>arch/arm/mach-realview/include/mach/platform.h which contains lots
>more...

So basically, what you and Mauro are recommending is that we move the *.h
file with register definitions to drivers/media?


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center
