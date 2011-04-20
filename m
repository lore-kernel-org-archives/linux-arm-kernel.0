From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 20 Apr 2011 09:00:15 -0400 (EDT)
Subject: [PATCH 0/3] fix some issues with the kernel decompressor
In-Reply-To: <20110420072156.GA28679@atomide.com>
References: <1303272904-31392-1-git-send-email-nicolas.pitre@linaro.org>
	<20110420072156.GA28679@atomide.com>
Message-ID: <alpine.LFD.2.00.1104200850030.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2011, Tony Lindgren wrote:

> * Nicolas Pitre <nicolas.pitre@linaro.org> [110419 21:12]:
> > Here some patches to fix some issues with the zImage code.  The LZMA
> > decompressor now works for me, and the DT append patch should work
> > on all platforms now too.
> 
> Weird still no luck here booting n900 zImage.. LZMA image prints
> corrupt error, and only works if the image is relocated further
> by 1MB or so. With the following hack n900 boots, so some size
> calculations still are wrong. No luck with DT append patch either.
> 
> Any ideas why the following helps on n900?

No idea.  This could indicate that the lzma code is crapping into memory 
outside of its output buffer.  The fact that my patch #2/3 makes lzma 
decompression suddenly work for me with no apparent explanation is not 
reassuring either.


Nicolas
