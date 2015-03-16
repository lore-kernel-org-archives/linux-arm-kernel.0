From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 16 Mar 2015 22:15:06 +0100
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <20150316210143.GF12397@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <201503162158.50587@pali> <20150316210143.GF12397@atomide.com>
Message-ID: <201503162215.06436@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 March 2015 22:01:43 Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [150316 13:59]:
> > On Monday 16 March 2015 16:29:39 Tony Lindgren wrote:
> > > I believe the last pending issues is the support for
> > > ATAG_REVISION in device tree mode as posted by Pali.
> > 
> > No. In DT boot there is missing /proc/atags file (readable
> > by userspace processes).
> 
> Oh OK thanks for the update.
> 
> > And also broken AES/SHA/MD5 support. Fix for crypto DT stuff
> > I already sent.
> 
> But this is not a regression in mainline with legacy boot vs
> device tree based booting, right? Sounds like it never worked
> in the mainline or am thinking of some other set of patches?
> 
> Regards,
> 
> Tony

In legacy board code are DMA channels defined. In DT files not. 
So I think this is regression. Omap secure devices are broken in 
both legacy & DT code, but non secure could work with legacy 
code. But all devices booted with DT are broken.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150316/7f5e42a4/attachment.sig>
