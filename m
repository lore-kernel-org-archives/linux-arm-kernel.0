From: balbi@ti.com (Felipe Balbi)
Date: Wed, 31 Oct 2012 12:12:33 +0200
Subject: [PATCH RFC] i2c: omap: Fix the revision register read
In-Reply-To: <CAM=Q2cssHRYFJprozOSJqXNgeCub27jyVXkhvvMaxz-Z44d_EA@mail.gmail.com>
References: <1351673959-5918-1-git-send-email-shubhrajyoti@ti.com>
 <CAM=Q2cssHRYFJprozOSJqXNgeCub27jyVXkhvvMaxz-Z44d_EA@mail.gmail.com>
Message-ID: <20121031101233.GC10094@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 31, 2012 at 03:02:57PM +0530, Shubhrajyoti Datta wrote:
> On Wed, Oct 31, 2012 at 2:29 PM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> > The revision register on OMAP4 is a 16-bit lo and a 16-bit
> > hi. Currently the driver reads only the lower 8-bits.
> > Fix the same by preventing the truncating of the rev register
> > for OMAP4.
> >
> > Also use the scheme bit ie bit-14 of the hi register to know if it
> > is OMAP_I2C_IP_VERSION_2.
> >
> > On platforms previous to OMAP4 the offset 0x04 is IE register whose
> > bit-14 reset value is 0, the code uses the same to its advantage.
> >
> > The dev->regs is populated after reading the rev_hi. A NULL check
> > has been added in the resume handler to prevent the access before
> > the setting of the regs.
> >
> tested on omap4sdp, omap3630 based beagle , omap3430sdp.

oh, now I see. You need to test on OMAP2 which has different revision
layout.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/feaae506/attachment.sig>
