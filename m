From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 27 Jan 2011 08:24:33 +0100
Subject: kexec on kirkwood kernels?
In-Reply-To: <20110127030024.GF19307@localhost>
References: <20110127030024.GF19307@localhost>
Message-ID: <20110127072433.GI1147@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Wed, Jan 26, 2011 at 10:00:24PM -0500, Eric Cooper wrote:
> Has anyone successfully used kexec to boot one kirkwood kernel from
> another?  I've been trying to do it on a Seagate DockStar, but
> all I see is this:
> 
>     # kexec -l --append="console=ttyS0,115200" zImage
>     # kexec -e
>     [   35.553632] Starting new kernel
>     Uncompressing Linux... done, booting the kernel.
> 
> and then nothing.  I've tried with both 2.6.35 and 2.6.38-rc1 kernels.
> I've tried modifying the kernel image to set the machine ID
> explicitly, but that makes no difference.  I wonder if the boot
> parameters are being passed correctly, but I don't know how to check
> without any console output. I do have a JTAG setup, but so far I've
> only used it cookbook-fashion to re-flash the u-boot NAND partition.
> I'm hoping someone can help me avoid having to use gdb over JTAG to
> resolve this.  Thanks.
Try enabling DEBUG_LL and EARLY_PRINTK in the kernel to boot and pass 

	earlyprintk

as kernel parameter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
