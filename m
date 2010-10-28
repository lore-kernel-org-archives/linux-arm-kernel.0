From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 27 Oct 2010 22:30:36 -0400 (EDT)
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <20101027221428.GB28391@n2100.arm.linux.org.uk>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
	<20101027221428.GB28391@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010272227380.31220@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 27 Oct 2010, Russell King - ARM Linux wrote:

> > +#else
> > +	.macro	addruart, rx, tmp
> 
> addruart is now expected to return two values, and 'tmp' ends up being
> misleading.  This is a recipe for mistakes unless this is corrected.
> It should be 'rp, rv' instead of 'rx, tmp'.

Also, it is probably not a good idea to return nothing. Otherwise the 
code using those macros will then work on random values that just 
happened to be in the corresponding register at the call location.


Nicolas
