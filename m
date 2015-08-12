From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 11 Aug 2015 23:24:45 -0700
Subject: enabling libgcc for 64-bit divisions, was Re: PROBLEM: XFS on ARM
 corruption 'Structure needs cleaning'
In-Reply-To: <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
References: <5579B804.9050707@skylable.com>
 <20150612122108.GB60661@bfoster.bfoster>
 <557AD4D4.3010901@skylable.com> <20150612225209.GA20262@dastard>
 <C6D0D499B56584katsuki.uwatoko@toshiba.co.jp>
Message-ID: <20150812062445.GA4520@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:56:25AM +0000, katsuki.uwatoko at toshiba.co.jp wrote:
> On Sat, 13 Jun 2015 08:52:09 +1000, Dave Chinner wrote:
> 
> > Yup, that's looking like a toolchain bug. Thread about arm directory
> > read corruption:
> 
> I think that this is not a toolchain bug, this is related to 
> Subject: [PATCH v2 1/1] ARM : missing corrupted reg in __do_div_asm
> http://www.spinics.net/lists/arm-kernel/msg426684.html

Maybe it's time to rely on gcc to handle 64 bit divisions now?

I've been pretty annoyed at the amount of 32-bit architecture build
failures due to the lack of support for native 64-bit divisions, and
the ugly do_div hackery to work around it.

We're living in a world where we are using a lot of 64-bit CPUs and
people optimize for them, so it might be a good time to start relying
on the compiler to get these right on older CPUs.

How bad is gcc's code for 64-bit divisions on arm and x86 these days?
Is there still a good case for offloading work the compiler should be
doing on the programmer?
