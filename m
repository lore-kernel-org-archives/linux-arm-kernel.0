From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 5 Apr 2015 15:52:10 +0200
Subject: ARM errata 430973 on multi platform kernels (was: OMAP3-N900: Add
 microphone bias voltages)
In-Reply-To: <20150405134528.GD9186@earth>
References: <1425236828-28349-1-git-send-email-jarkko.nikula@bitmer.com>
 <201504051526.14575@pali> <20150405134528.GD9186@earth>
Message-ID: <201504051552.10522@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 April 2015 15:45:28 Sebastian Reichel wrote:
> Hi,
> 
> On Sun, Apr 05, 2015 at 03:26:14PM +0200, Pali Roh?r wrote:
> > > > > Yes so it seems, and the bootloaders should really set
> > > > > it. It's also disabled for multiplatform builds.
> > > > 
> > > > These are now done in u-boot as of: v2015.04-rc4
> > > > 
> > > > http://git.denx.de/?p=u-boot.git;a=commit;h=c6f90e1418a8
> > > > 4fe5 fa463b38403bd1845cb6a59c
> > > 
> > > Seems like "include/configs/nokia_rx51.h" has been
> > > forgotten. Note, that the kernel must still be able to
> > > enable the bit itself (in case NOLO is used without
> > > u-boot).
> > 
> > You must not expect that bootloader set something. Nokia
> > N900 has closed and signed bootloader which cannot be
> > easily replaced and or fixed.
> > 
> > For N900 there is U-Boot but it does not support lot of
> > things (load kernel via usb or serial) so for developers it
> > is better to use original Nokia bootloader.
> 
> Yes, I'm aware of that. I think having the IBE bit set in
> u-boot has advantages nevertheless. I think the kernel can't
> enable the bit sufficiently early if its compiled in
> thumb-mode itself (CONFIG_THUMB2_KERNEL).
> 
> So I suggest to enable the IBE bit in the kernel (that part is
> already done) *and* in u-boot.
> 
> -- Sebastian

Yes. Code for both (U-Boot and linux kernel) exists and are 
already included.

In linux kernel code is since 3.14-rc6 and in U-Boot code is 
there since beginning of Nokia N900 support (2013.04) directly in 
board code.

I believe that you guys do not remove or break that code :-)

Nokia N900 needs slightly different code for setting IBE bit as 
other omap3 boards. For info is in commit message of commit 
4748a7240284b0f68bd47a66365c2cd561939830.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150405/8fd2b79f/attachment.sig>
