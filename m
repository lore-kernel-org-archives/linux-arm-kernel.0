From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 18 Nov 2010 09:15:28 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <201011180838.26679.alexander.stein@systec-electronic.com>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<20101109140455.GA6680@n2100.arm.linux.org.uk>
	<AANLkTi=6OE=50EExgkay2ycuSPFsOp4E-RmxkNktK_Xk@mail.gmail.com>
	<201011180838.26679.alexander.stein@systec-electronic.com>
Message-ID: <20101118081528.GI8942@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 08:38:26AM +0100, Alexander Stein wrote:
> Soory for late answer,
> 
> On Saturday 13 November 2010, 11:47:41 Albin Tonnerre wrote:
> > <linux@arm.linux.org.uk> wrote:
> > > Is it really faster to copy an uncompressed image than it is to
> > > decompress using LZMA with caches on?
> > 
> > In my experience, using LZMA is painfully slow on older ARM CPUs.
> > 
> > If you really need to boot quickly you might want to try LZO, which
> > should give you results close to the uncompressed performance. It
> > might still be slower though, especially if you're able to load your
> > kernel image to memory fairly quickly
> 
> We only have experience with GZIP. Our compressed kernel is ~1,8MB and 
> uncompressed ~4MB.
> On an AT91 ARM9 SoC the decompression takes about 1-2s of time. Caches should 
> be disabled, as far as I could see in decompression code.
Caches are enabled in line 248 of
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/boot/compressed/head.S;h=6825c34646d4e02f24b0eefe7ab4e012bca05208;hb=HEAD

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
