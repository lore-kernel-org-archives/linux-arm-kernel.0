From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Apr 2017 14:07:53 +0000
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <20170418073526.GA6056@linux-x5ow.site>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
 <20170418073526.GA6056@linux-x5ow.site>
Message-ID: <1492524472.2628.3.camel@sandisk.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-18 at 09:35 +0200, Johannes Thumshirn wrote:
> On Mon, Apr 17, 2017 at 04:10:03PM -0700, Bart Van Assche wrote:
> > The global variable 'rd_size' is declared as 'int' in source file
> > arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> > drivers/block/brd.c. Fix this inconsistency.
> > 
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: <yanaijie@huawei.com>
> > Cc: <zhaohongjiang@huawei.com>
> > Cc: <miaoxie@huawei.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: linux-block at vger.kernel.org
> > ---
> > diff --git a/include/linux/brd.h b/include/linux/brd.h
> > new file mode 100644
> > index 000000000000..dbb0f92fefc8
> > --- /dev/null
> > +++ b/include/linux/brd.h
> > @@ -0,0 +1 @@
> > +extern unsigned long rd_size;
> 
> Small nit, can you add an include guard here as well?

Hello Johannes,

Thanks for the review. But are you aware that with the current content an
include guard is overkill because it is safe to evaluate the "extern unsigned
long rd_size" declaration multiple times?

Bart.
