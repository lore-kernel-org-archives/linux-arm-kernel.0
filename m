From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 Apr 2015 11:34:14 -0500
Subject: [RFC 5/6] usb: gadget: atmel_usba: use atmel_io.h to provide
 on-chip IO
In-Reply-To: <553FB681.4040505@codethink.co.uk>
References: <1427370354-21247-1-git-send-email-ben.dooks@codethink.co.uk>
 <1427370354-21247-6-git-send-email-ben.dooks@codethink.co.uk>
 <20150326115647.GD16148@samfundet.no>
 <20150427205529.GH25136@saruman.tx.rr.com>
 <553FA9DE.20406@codethink.co.uk>
 <20150428163057.GE18263@saruman.tx.rr.com>
 <553FB681.4040505@codethink.co.uk>
Message-ID: <20150428163414.GG18263@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 05:34:09PM +0100, Ben Dooks wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On 28/04/15 17:30, Felipe Balbi wrote:
> > Hi,
> > 
> > On Tue, Apr 28, 2015 at 04:40:14PM +0100, Ben Dooks wrote:
> >>>>> /* Register access macros */ -#ifdef CONFIG_AVR32 -#define 
> >>>>> usba_io_readl	__raw_readl -#define usba_io_writel
> >>>>> __raw_writel -#define usba_io_writew	__raw_writew -#else
> >>>>> -#define usba_io_readl	readl_relaxed -#define
> >>>>> usba_io_writel writel_relaxed -#define usba_io_writew
> >>>>> writew_relaxed -#endif +#define usba_io_readl
> >>>>> atmel_oc_readl +#define usba_io_writel atmel_oc_writel
> >>>>> +#define usba_io_writew	atmel_oc_writew
> >>>> 
> >>>> Same comment as earlier patch, it would be nice to remove
> >>>> the define usba_io_{read,write}{l,w} defines in a follow-up
> >>>> patch.
> >>> 
> >>> I'm fine with this too. Is this targetted at v4.2 ?
> >> 
> >> Yes, although we may move it to the soc specific include
> >> directories to avoid adding more to linux/
> >> 
> >> I will be sorting this out next week.
> > 
> > I would rather not see drivers including anything from asm or
> > mach-* (unless strictly necessary), otherwise it's a pain to
> > build-test anything
> 
> 
> Thanks. I think the soc/ include is available for all. I will check this
> tomorrow.

if that's the case, no issues from my side :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150428/27cfa000/attachment.sig>
