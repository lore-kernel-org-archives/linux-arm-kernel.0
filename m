From: sam@ravnborg.org (Sam Ravnborg)
Date: Sat, 13 Aug 2011 00:03:17 +0200
Subject: [PATCH] ARM: zImage: Skip relinking if nothing changes
In-Reply-To: <CACqU3MX=-10ouxCqWcBP7MW3_O4_RSLG9wRY8X4iEh5ydQa1AQ@mail.gmail.com>
References: <4E457682.5020107@codeaurora.org>
	<1313175602-21834-1-git-send-email-sboyd@codeaurora.org>
	<CACqU3MUq5M-XPOxV=8GKyEzjEzpmdeaF+mGrXJrK+ZZxa4SdeQ@mail.gmail.com>
	<20110812205520.GL4775@n2100.arm.linux.org.uk>
	<CACqU3MX=-10ouxCqWcBP7MW3_O4_RSLG9wRY8X4iEh5ydQa1AQ@mail.gmail.com>
Message-ID: <20110812220316.GA28845@merkur.ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> I suspect this would have done the job:
> 
> $(obj)/font.o: $(srctree)/drivers/video/console/font_acorn_8x8.c
>         $(cmd,cc_o_c)'

I prefer using $(call,shipped) and let kbuild figure out how
build an .o file from a .c file.

In other words - avoiding use of the internal to Makefile.build
variables in various places.

	Sam
