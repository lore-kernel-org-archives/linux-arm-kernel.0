From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 12 Sep 2012 15:44:27 +0200
Subject: [PATCHv7 00/23]I2C big cleanup
In-Reply-To: <20120912101850.GB2624@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <20120911220048.GD27031@pengutronix.de> <50505FDC.4090500@ti.com>
 <20120912101850.GB2624@pengutronix.de>
Message-ID: <20120912134427.GC16547@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 12:18:50PM +0200, Wolfram Sang wrote:
> 
> > I donot see the warning. Am I missing something?
> 
> I deleted my logfiles already. Ignore it for now, if it comes up again
> with your new series, I will give a more detailed pointer.

Sorry, the section mismatch was not related to I2C it seems:

WARNING: vmlinux.o(.data+0x30958): Section mismatch in reference from the variable rx51_si4713_dev to the (unknown reference) .init.data:(unknown)
The variable rx51_si4713_dev references
the (unknown reference) __initdata (unknown)
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Got it with an "allnoconfig" and then selecting MMU and OMAP.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120912/bb3a742e/attachment.sig>
