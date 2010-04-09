From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Apr 2010 12:13:00 +0100
Subject: [RFC] Initial attempt to make ARM use LMB
In-Reply-To: <201003311443.13568.jeremy.kerr@canonical.com>
References: <20100325233248.GM24984@n2100.arm.linux.org.uk>
	<201003311443.13568.jeremy.kerr@canonical.com>
Message-ID: <20100409111300.GB2804@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 02:43:13PM +0800, Jeremy Kerr wrote:
> Hi Russell,
> 
> > LMB... logical memory blocks.
> 
> Nice, will be good for the DT work too.
> 
> > @@ -483,6 +484,13 @@ static void __init build_mem_type_table(void)
> > 
> >  #define vectors_base()	(vectors_high() ? 0xffff0000 : 0)
> > 
> > +static void __init *early_alloc(unsigned long sz)
> > +{
> > +      void *ptr = __va(lmb_alloc(sz, sz));
> > +      memset(ptr, 0, PAGE_SIZE);
> 
> memset(ptr, 0, sz) ?

Yes, thanks for catching that.  That's not fixed in the revised version
I just sent, but will be fixed in the final version.  (IOW, I just
committed that correction.)
