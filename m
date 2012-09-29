From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Sep 2012 21:47:21 +0100
Subject: s3c2410 bast (== lists.arm.linux.org.uk) - appears to be broken
 with 3.1.8...
Message-ID: <20120929204721.GB6933@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've not been able to get very far with debugging this, because there
appears to be *multiple* issues here.

1. It appears that LZMA fails on this platform.  Gzip'd zImage's also
   occasionally fail with CRC errors.  ABLE reports loading the right
   size of image though.

2. When the decompressor does work, no output from the kernel is
   forthcoming.  Attempts to use DEBUG_LL have proved fruitless so far
   because of (1).

I won't be around much for the next week or so, so I won't be able to
do any debugging.  I suggest those with a S3C2410 platform test out the
3.x.x kernels and report back successes/failures.
