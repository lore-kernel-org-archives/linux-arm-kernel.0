From: tytso@mit.edu (Theodore Ts'o)
Date: Sun, 16 Feb 2014 16:43:54 -0500
Subject: Recent 3.x kernels: Memory leak causing OOMs
In-Reply-To: <20140216200503.GN30257@n2100.arm.linux.org.uk>
References: <20140216200503.GN30257@n2100.arm.linux.org.uk>
Message-ID: <20140216214354.GA12947@thunk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 08:05:04PM +0000, Russell King - ARM Linux wrote:
> I have another machine which OOM'd a week ago with plenty of unused swap
> - it uses ext3 on raid1 and is a more busy system.  That took 41 days
> to show, and upon reboot, it got a kernel with kmemleak enabled.  So far,
> after 7 days, kmemleak has found nothing at all.

If kmemleak doesn't show anything, then presumably it's not a leak of
the slab object.  Does /proc/meminfo show anything interesting?  Maybe
it's a page getting leaked (which wouldn't be noticed by kmemleak)

       	    	    	   	  	      - Ted
