From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 28 Dec 2015 22:23:09 +0000
Subject: [PATCH] ARM: mm: Enable PXN when running non-LPAE kernel on LPAE
In-Reply-To: <005201d1415a$e5fe5ed0$b1fb1c70$@samsung.com>
References: <005201d1415a$e5fe5ed0$b1fb1c70$@samsung.com>
Message-ID: <1451341389.25978.39.camel@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-12-28 at 19:31 +0900, Jungseung Lee wrote:
> 2015-05-11 23:36 GMT+09:00 Catalin Marinas <catalin.marinas@arm.com>:
> > On Mon, May 11, 2015 at 05:09:35PM +0900, Jungseung Lee wrote:
> > > Hi, Ben.
> > > 
> > > 2014-12-25 2:20 GMT+09:00 Catalin Marinas :
> > > > On Wed, Dec 24, 2014 at 03:54:28PM +0000, Ben Hutchings wrote:
> > > > > The VMSA field of MMFR0 (bottom 4 bits) is incremented for each
> > > > > added feature.??PXN is supported if the value is >= 4 and LPAE
> > > > > is supported if it is >= 5.
> > > > > 
> > > > > In case a kernel with CONFIG_ARM_LPAE disabled is used on a
> > > > > processor that supports LPAE, we can still use PXN in short
> > > > > descriptors.??So check for >= 4 not == 4.
> > > > > 
> > > > > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > > > > Cc: Jungseung Lee <js07.lee@gmail.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > 
> > > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > 
> > > Is this patch handled?
> > 
> > If it's not in mainline already, than it probably isn't handled.
> > 
> > > or you can send it to Russell's patch system:
> > > http://www.arm.linux.org.uk/developer/patches/
> > 
> > Check mainline first, otherwise please submit it.
> > 
> 
> > --
> > Catalin
> 
> Hi, Ben
> 
> It looks still not submitted yet. Could you send it to Russell's patch
> system?
> http://www.arm.linux.org.uk/developer/patches/
> 

I've never needed to use a web-based system to submit kernel patches
before, and I'm not going to start now. ?Someone else can re-submit
this if they want it.

Ben.

-- 
Ben Hutchings
I'm not a reverse psychological virus.  Please don't copy me into your sig.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 811 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151228/813ab5a0/attachment.sig>
