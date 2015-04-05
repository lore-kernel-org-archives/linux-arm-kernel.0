From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 5 Apr 2015 15:45:28 +0200
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900:
 Add microphone bias voltages)
In-Reply-To: <201504051526.14575@pali>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <CAOCHtYjCtmJNrkD0x78bm9b7hNvTKsZD2C2m5N=nR7p73R4zcg@mail.gmail.com>
 <20150405130045.GB9186@earth> <201504051526.14575@pali>
Message-ID: <20150405134528.GD9186@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Apr 05, 2015 at 03:26:14PM +0200, Pali Roh?r wrote:
> > > > Yes so it seems, and the bootloaders should really set it.
> > > > It's also disabled for multiplatform builds.
> > > 
> > > These are now done in u-boot as of: v2015.04-rc4
> > > 
> > > http://git.denx.de/?p=u-boot.git;a=commit;h=c6f90e1418a84fe5
> > > fa463b38403bd1845cb6a59c
> > 
> > Seems like "include/configs/nokia_rx51.h" has been forgotten.
> > Note, that the kernel must still be able to enable the bit
> > itself (in case NOLO is used without u-boot).
> 
> You must not expect that bootloader set something. Nokia N900 has 
> closed and signed bootloader which cannot be easily replaced and 
> or fixed.
> 
> For N900 there is U-Boot but it does not support lot of things 
> (load kernel via usb or serial) so for developers it is better to 
> use original Nokia bootloader.

Yes, I'm aware of that. I think having the IBE bit set in u-boot has
advantages nevertheless. I think the kernel can't enable the bit
sufficiently early if its compiled in thumb-mode itself
(CONFIG_THUMB2_KERNEL).

So I suggest to enable the IBE bit in the kernel (that part is
already done) *and* in u-boot.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150405/40f70460/attachment.sig>
