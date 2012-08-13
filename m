From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 13 Aug 2012 13:20:27 +0300
Subject: [PATCH v2] mtd: gpmi: add NAND write verify support
In-Reply-To: <50288C0E.5060400@freescale.com>
References: <1344698728-8709-1-git-send-email-shijie8@gmail.com>
 <CAF4G-tKN683_EQCGcG4G8jMU5K6TamaHUv__3ugGUoEg_LPrcQ@mail.gmail.com>
 <50288C0E.5060400@freescale.com>
Message-ID: <1344853227.3393.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-08-13 at 13:09 +0800, Huang Shijie wrote:
> ? 2012?08?13? 12:44, Artem Bityutskiy ??:
> > On Sat, Aug 11, 2012 at 6:25 PM, Huang Shijie<shijie8@gmail.com>  wrote:
> >> Add NAND write verify support in gpmi-nand driver.
> >>
> >> This patch fixes a kernel crash when we select
> >> CONFIG_MTD_NAND_VERIFY_WRITE=y, and do some write tests:
> > I would just kill ONFIG_MTD_NAND_VERIFY_WRITE entirely. Some drivers
> > do not support it and it does not work for sub-pages for long time.
> > Both UBI and JFFS2 are able to read verify what they wrote already.
> > There are also MTD tests which do this verification. So I think there
> > is no reason to keep this in the NAND layer, let alone wasting RAM in
> > the driver to support this feature.
> >
> > I am also removing the -stable mailing list - ne need to spam it.
> >
> thanks a lot. Maybe we should send a patch to remove the 
> CONFIG_MTD_NAND_VERIFY_WRITE feature entirely.

I'd suggest that instead. I have huge back-log, so wouldn't be able to
process it quickly, but at some point I would take it to the l2 tree.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120813/b1312dac/attachment.sig>
