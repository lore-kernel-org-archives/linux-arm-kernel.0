From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 13 Jan 2010 15:26:14 +0100
Subject: [PATCH] ARM: Fix uncompress code compile for different defines
	of static(void)
In-Reply-To: <20100113084937.GA19352@pengutronix.de>
References: <20100113021939.GE2986@atomide.com>
	<20100113084937.GA19352@pengutronix.de>
Message-ID: <20100113142614.GA1252@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 13, 2010 at 09:49:37AM +0100, Uwe Kleine-K?nig wrote:
> On Tue, Jan 12, 2010 at 06:19:40PM -0800, Tony Lindgren wrote:
> > Because of the include of the decompress_inflate.c file from
> > boot/compress/misc.c, there are different flush() defines:
> > 
> > In file included from arch/arm/boot/compressed/misc.c:249:
> > arch/arm/boot/compressed/../../../../lib/decompress_inflate.c:138:29: error: macro "flush" passed 2 arguments, but takes just 0
> > 
> > Fix this by removing the define of flush() in misc.c for
> > CONFIG_DEBUG_ICEDCC as it's already defined in mach/uncompress.h,
> > and that is being included unconditionally.
> > 
> > Also use a static inline function instead of define
> > for mach-mxc and mach-gemini to avoid similar bug
> > for those platforms.
> As arch/arm/boot/compressed/misc.c is compiled with -Dstatic= and this
> is AFAIK the only user of uncompress.h I'd skip "static" and/or add a
> comment telling that static is redundant here.
while reading my reply I noticed that I don't understand the subject.
"different defines of static(void)"?

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
