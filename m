From: albin.tonnerre@free-electrons.com (Albin Tonnerre)
Date: Wed, 11 Nov 2009 18:07:29 +0100
Subject: Status of bzip2 and lzma kernel compression for ARM?
In-Reply-To: <20091111163404.GA4362@deprecation.cyrius.com>
References: <20091111163404.GA4362@deprecation.cyrius.com>
Message-ID: <20091111170729.GG2605@pc-ran3241.res.insa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2009 16:34 +0000, Martin Michlmayr wrote :
> What's the status of bzip2 and lzma kernel compression for ARM?
> The last messages I can find about this topic are from June and July:
> http://lkml.org/lkml/2009/6/24/481

Regarding Bzip2, some testing showed that the decompressor needs at least 3.5Mb
of memory available for malloc(), which is not available on ARM as head.S
allocates only 64kb, so I'm sure what to do about it. At this stage, I think
the most sensible thing to do is forgetting about using bzip2 on ARM.

> Where can I find the current patch to test and is anyone planning to
> submit it for inclusion?

The LZMA patch relies on patch 2/4 of the LZO patchset, which I resubmitted
today: http://lkml.org/lkml/2009/11/11/129. I'll likely submit the LZMA patch
once I get Russell's approval on the ARM part of the LZO patchset. In the
meantime, you can get it here: http://alioth.debian.org/~lutin-guest/patches/

Regards,
-- 
Albin Tonnerre, Free Electrons
Kernel, drivers and embedded Linux development,
consulting, training and support.
http://free-electrons.com
