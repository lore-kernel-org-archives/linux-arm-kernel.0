From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Tue, 27 Jan 2015 16:26:12 +0100
Subject: N900 v3.19-rc5 arm atags_to_fdt.c is broken
In-Reply-To: <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
References: <201501232239.55801@pali> <20150127133739.GB25306@amd>
 <alpine.LFD.2.11.1501271014160.1322@knanqh.ubzr>
Message-ID: <201501271626.12365@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 January 2015 16:16:24 Nicolas Pitre wrote:
> On Tue, 27 Jan 2015, Pavel Machek wrote:
> > > > > I would say, problem is because omap3-n900 binary DT
> > > > > is too large
> > > 
> > > I agree.
> > > 
> > > > OK if that's the case, then your patch makes sense to
> > > > me. It also seems we can have the temporary stack be
> > > > larger than the initial stack just for atags_to_fdt.
> > > 
> > > The stack size isn't the issue, but rather its location. 
> > > We need to position it away from the DT data.  The DT
> > > size is known and we could use that, plus some room for
> > > the insertion of new data coming from the ATAG
> > > conversion.
> > 
> > > Something like the following would be a more robust 
solution:
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > 
> > (Note, that in 3.19 dts for n900 got too big, so we are
> > actually triggering old bugs. That means that this is a
> > regression fix, and should go in ASAP).
> 
> It is queued here:
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id
> =8294/1
> 
> 
> Nicolas

I tested your patch and fdt_open_into() does not return error 
FDT_ERR_NOSPACE anymore. It is working. So you can add my

Tested-by: Pali Roh?r <pali.rohar@gmail.com>

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/8da05adc/attachment.sig>
