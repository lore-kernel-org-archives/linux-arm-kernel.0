From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Apr 2011 09:55:14 -0700
Subject: [PATCH 0/3] fix some issues with the kernel decompressor
In-Reply-To: <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<20110420072156.GA28679@atomide.com>
	<alpine.LFD.2.00.1104200850030.24613@xanadu.home>
Message-ID: <20110420165514.GE10402@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nicolas.pitre@linaro.org> [110420 05:57]:
> On Wed, 20 Apr 2011, Tony Lindgren wrote:
> 
> > * Nicolas Pitre <nicolas.pitre@linaro.org> [110419 21:12]:
> > > Here some patches to fix some issues with the zImage code.  The LZMA
> > > decompressor now works for me, and the DT append patch should work
> > > on all platforms now too.
> > 
> > Weird still no luck here booting n900 zImage.. LZMA image prints
> > corrupt error, and only works if the image is relocated further
> > by 1MB or so. With the following hack n900 boots, so some size
> > calculations still are wrong. No luck with DT append patch either.
> > 
> > Any ideas why the following helps on n900?
> 
> No idea.  This could indicate that the lzma code is crapping into memory 
> outside of its output buffer.  The fact that my patch #2/3 makes lzma 
> decompression suddenly work for me with no apparent explanation is not 
> reassuring either.

With gzip kernel looks like I need to move the kernel further by 8MB
instead of 1MB for some reason..

Tony
