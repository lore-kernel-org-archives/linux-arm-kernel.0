From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Tue, 2 Dec 2014 22:28:16 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141128202719.GU2817@atomide.com>
References: <20141027200008.GR2560@atomide.com> <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com>
Message-ID: <201412022228.16421@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 21:27:19 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [141127 03:34]:
> > On Thursday 27 November 2014 02:12:04 Tony Lindgren wrote:
> > > Thinking about this probably the best long term solution
> > > is to pass optional board_revision in the kernel cmdline
> > > that can be parsed early and copied to system_rev
> > > variable.
> > 
> > Not possible. Our bootloader is closed & proprietary. I
> > tried to replace it with u-boot I was not able to do that.
> > So we will use that Nokia closed bootloader forever and it
> > can provide data only in ATAG structure.
> 
> I'm using just mainline u-boot flashed as kernel for nolo that
> then loads the kernel.
> 
> For passing the board revision using the pass through u-boot
> is probably the best long term solution. U-boot can read the
> ATAGs from nolo and modify the .dtb for the revision
> information.
> 
> Are you saying there are some issues with that?
> 
> > > Or if you can think of some other way to get it, we can
> > > set system_rev in pdata-quirks.c.
> > > 
> > > Or maybe add some code to copy the ATAGs somewhere where
> > > they are out of the way and don't conflict with the device
> > > tree data? Then we can query ATAG_REVISION from
> > > pdata-quirks.c and set system_rev.
> > 
> > If we are able to read ATAG from pdata-quirks, then we can
> > parse it there and fix problems... But I do not know if
> > address of ATAG structure is available there...
> 
> Are there other ATAGs needed beyond the ATAG_REVISION?
> 
> Regards,
> 
> Tony

Ouch... Also ATAG_CMDLINE... which is probably reason why cmdline 
passed from bootloader is ignored.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141202/dba85c86/attachment-0001.sig>
