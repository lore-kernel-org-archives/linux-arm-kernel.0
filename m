From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 09 Jan 2012 13:20:13 +0100
Subject: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode,
 remove unsupported 15bit modes
In-Reply-To: <20120109121322.GM21765@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 9 Jan 2012 12:13:22 +0000")
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com>
 <20120109121322.GM21765@n2100.arm.linux.org.uk>
Message-ID: <87mx9xdq4i.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:

Hi,

 Russell> You describe the RGB555 vs RGB565 via the bitfield values in
 Russell> var->red, var-> green and var->blue.  So, RGB(or BGR)565 has
 Russell> var->green.length with 6, and RGB(or BGR)555 has this as 5.
 Russell> In both cases, bits_per_pixel is 16 as that's the width of a
 Russell> pixel in the frame buffer.

 Russell> If the bitfield can't be interpreted by the driver as
 Russell> identifying one of these combinations, then you're supposed to
 Russell> chose one (and in the case where it's fixed by hardware, you
 Russell> set the bitfields according to what the hardware supports.)

Indeed, and as the hardware can only interprete 1/2/4/8 paletted and
16/24 RGB, we shouldn't claim to support 15bit.

-- 
Bye, Peter Korsgaard
