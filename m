From: colin.tuckley@arm.com (Colin Tuckley)
Date: Tue, 26 Jan 2010 08:23:24 -0000
Subject: [PATCH] ARM: RealView SD/MMC Card detection and
	write-protect	using GPIOLIB
In-Reply-To: <20100125180440.GD22481@n2100.arm.linux.org.uk>
References: <20100125125820.5028.29129.stgit@ARM03585.cambridge.arm.com>
	<20100125180440.GD22481@n2100.arm.linux.org.uk>
Message-ID: <000001ca9e60$d4487d90$9fca010a@Emea.Arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 

> No; if it's broken then it's because something's wrong, and I 
> think there
> was a mail about that recently.  I don't particularly like 
> forcing options
> on when there's better solutions to the problem (like fixing 
> the cause of
> the actual breakage.)

Actually, the patch description is slightly wrong/misleading.

The original patch did break the card detection on some boards. Also the
configuration options mentioned do need setting for things to work properly.
I think it's that the PL061 driver didn't get included in the kernel by the
original patch. Maybe it should be added to the realview_default config
files?

The problem here I think is that someone implemented gpiolib for sdcard
detection on mach-realview without doing any testing. When I started working
on a kernel with gpiolib I found the detection broken. After a lot of
experimentation and discussion with Catalin we decided that the patch I
submitted was the best way forward.

If it's not acceptable please suggest something that is.

Colin

-- 
Colin Tuckley - ARM Ltd.
110 Fulbourn Rd
Cambridge, CB1 9NJ
Tel: +44 1223 400536 
