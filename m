From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jan 2012 09:14:58 +0000
Subject: [PATCH] ARM: prom.h: Fix build error by removing unneeded
 header file
In-Reply-To: <20120104080731.GD15503@ponder.secretlab.ca>
References: <1325521143-29482-1-git-send-email-festevam@gmail.com>
 <20120104080731.GD15503@ponder.secretlab.ca>
Message-ID: <20120104091458.GH2914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2012 at 01:07:31AM -0700, Grant Likely wrote:
> On Mon, Jan 02, 2012 at 02:19:03PM -0200, Fabio Estevam wrote:
> > Fix the following build error:
> > 
> >   CC [M]  fs/udf/balloc.o
> > In file included from /home/fabio/next/linux-next/arch/arm/include/asm/prom.h:16,
> >                  from include/linux/of.h:140,
> >                  from include/asm-generic/gpio.h:7,
> >                  from arch/arm/plat-mxc/include/mach/irqs.h:14,
> >                  from /home/fabio/next/linux-next/arch/arm/include/asm/irq.h:4,
> >                  from /home/fabio/next/linux-next/arch/arm/include/asm/hardirq.h:6,
> >                  from include/linux/hardirq.h:7,
> >                  from include/linux/highmem.h:8,
> >                  from include/linux/pagemap.h:10,
> >                  from include/linux/buffer_head.h:13,
> >                  from fs/udf/udfdecl.h:11,
> >                  from fs/udf/balloc.c:22:
> > /home/fabio/next/linux-next/arch/arm/include/asm/setup.h:146: error: redefinition of 'struct tag'
> > 
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Well that's ugly.  There are two definitions of struct tag.  The patch
> does fix the compile error, but it could easily reoccur.  Ideally one
> of the structures should be renamed.

I'm not renaming the ARM one as it's an API thing which gets shared with
boot loaders.  Changing that is likely to cause breakage outside the
kernel tree.
