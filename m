From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Feb 2012 19:31:58 +0000
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <011c01ccf107$5624d020$026e7060$%kim@samsung.com>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
 <CABb+yY1E0_ZhTv8QvRAfgUvc=2Vz+ioYbsEczknP5dKcL2ZCbw@mail.gmail.com>
 <00f401ccf0f8$0db84ec0$2928ec40$%kim@samsung.com>
 <CABb+yY0j0j7Qw4MCwP_F+DKzmpdmZ3x0QC2Ktj2qmGnL=Ocx0Q@mail.gmail.com>
 <011c01ccf107$5624d020$026e7060$%kim@samsung.com>
Message-ID: <20120222193158.GA7041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 11:11:49AM +0900, Kukjin Kim wrote:
> Unfortunately, I couldn't find his name for dma/pl330.c from my side and
> if required, he can do it later. Why should I do?
> 
> I'm very unhappy with this talking and I think, there is no more useful
> talking with you. I'd like to know opinions from Russell King(ARM
> maintainer) or Vinod Koul (DMA maintainer) for this.

Let's take a step back, and see how things are in mainline at the
moment.

1. arch/arm/common/pl330.c and drivers/dma/pl330.c have this header:
 * Copyright (C) 2010 Samsung Electronics Co. Ltd.
 *      Jaswinder Singh <jassi.brar@samsung.com>

That, to me, means that Samsung hold the copyrights, and Jaswinder Singh
was the author of it.  Jaswinder has no copyright on the code.  That's
pretty standard if you're employed by a company (and some employment
contracts even assert that any idea you have, even outside work time,
becomes the property of the company you are working for... but that's
a different matter.)

2. The authorship on the lines in these files are:
$ git blame arch/arm/common/pl330.c | cut -b 11-26 |sort | uniq -c
   1892 Jassi Brar      
     66 Javi Merino     
      2 Lucas De Marchi 
$ git blame drivers/dma/pl330.c | cut -b 11-26 |sort | uniq -c
    185 Boojin Kim
      2 Dave Martin
    795 Jassi Brar
      8 Rob Herring
      1 Russell King
     53 Thomas Abraham
      2 Tushar Behera
      7 Vinod Koul

So, quite clearly, most of the driver code was written by Jassi, presumably
while under the employment of Samsung.  Note that Boojin has contributed
more lines of code than Javi.

3. The new header on the combined file has this:
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *             http://www.samsung.com
+ * Boojin Kim <boojin.kim@samsung.com>
  *
  * Copyright (C) 2010 Samsung Electronics Co. Ltd.
  *     Jaswinder Singh <jassi.brar@samsung.com>

Given that this driver is merely taking arch/arm/common/pl330.c and
merging it into drivers/dma/pl330.c, it's not fair to add that if all
that's happened is code has been moved around, because it makes it look
like Boojin Kim is taking credit just for moving code.

What would be fair is to add the first _two_ lines indicating that
Samsung maintains the copyright to 2012.

However, it would *not* be unreasonable to add Boojin Kim to
drivers/dma/pl330.c as a separate patch _before_ or _after_ this patch,
and I think that would be more warranted than adding Javi Merino as an
author based on the above stats.

I think Boojin Kim is quite justified in having a mention at the top of
the file - but as a separate patch.  And Samsung are quite justified in
updating their copyright.

So, I think the problem is how this has been done.  Separate the two
changes and let's move on.
