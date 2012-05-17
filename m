From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 May 2012 14:42:17 +0300
Subject: [PATCH v7 0/3] Add PMECC support for at91 nand flash driver
In-Reply-To: <4FB49B67.2040705@atmel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337159858.24809.21.camel@sauron.fi.intel.com>
 <4FB49B67.2040705@atmel.com>
Message-ID: <1337254937.2564.1.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-17 at 14:32 +0800, Josh Wu wrote:
> > --------------------------------------------------------------------------------
> >
> > Successfully built configuration "arm-at91cap9_defconfig,arm,arm-unknown-linux-gnueabi-", results:
> >
> > --- before_patching.log
> > +++ after_patching.log
> > @@ @@
> > +drivers/mtd/nand/atmel_nand.c: In function 'atmel_pmecc_nand_init_params':
> > +drivers/mtd/nand/atmel_nand.c:910:29: warning: assignment from incompatible pointer type [enabled by default]
> > +drivers/mtd/nand/atmel_nand.c:910:50: warning: incorrect type in assignment (different argument counts) [sparse]
> > +drivers/mtd/nand/atmel_nand.c:910:50:    expected int ( *read_page )( ... ) [sparse]
> > +drivers/mtd/nand/atmel_nand.c:910:50:    got int ( static [toplevel] *<noident>  )( ... ) [sparse]
> > +drivers/mtd/nand/atmel_nand.c:912:30: warning: assignment from incompatible pointer type [enabled by default]
> > +drivers/mtd/nand/atmel_nand.c:912:51: warning: incorrect type in assignment (different argument counts) [sparse]
> > +drivers/mtd/nand/atmel_nand.c:912:51:    expected void ( *write_page )( ... ) [sparse]
> > +drivers/mtd/nand/atmel_nand.c:912:51:    got void ( static [toplevel] *<noident>  )( ... ) [sparse]
> >
> > --------------------------------------------------------------------------------
> 
> Since I used Code Sourcery tools-chain (2010q1-202) to compile the code 
> and I didn't get any warning.
> 
> So I am not sure what's caused above warnings. From the warning message, 
> I don't know the reason exactly.

The warnings come from sparse, not gcc. And they are introduced by this
patch - aiaiai informs only about new warnings, otherwise it would be
useless.

> > WARNING:LONG_LINE: line over 80 characters
> > #642: FILE: drivers/mtd/nand/atmel_nand.c:567:
> > +                               a = readw_relaxed(alpha_to + tmp % host->cw_len);
> >
> > WARNING:LONG_LINE: line over 80 characters
> > #664: FILE: drivers/mtd/nand/atmel_nand.c:589:
> > +                               a = readw_relaxed(index_of + host->smu[i + 1][k]);
> >
> > total: 0 errors, 3 warnings, 1136 lines checked
> 
> For these two warnings, I would like to keep it for more readable. but 
> if you would like to fix the warning, then I can fix them too by split 
> into two lines.

Fine with me.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120517/ab3233ab/attachment.sig>
