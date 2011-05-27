From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 27 May 2011 14:58:27 -0400 (EDT)
Subject: uncompress and ll debug uart consolidation
In-Reply-To: <4DDFE906.9020101@gmail.com>
References: <4DDFE906.9020101@gmail.com>
Message-ID: <alpine.LFD.2.00.1105271454280.3207@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 May 2011, Rob Herring wrote:

> I started looking at the 10 duplicate implementations of PL01x uart code in
> various mach/uncompress.h. My first thought was just consolidate those into 1
> uncompress-pl01x.h header similar to debug-pl01x.S.
> 
> However, the LL debug macros are basically doing the same thing and are
> already used by compressed/head.S, so why not make the uncompress code use
> them? The debug macros are already included when DEBUG is defined for
> compressed/head.S. It's quite trivial to use putc from head.S in misc.c
> instead of the C version. To take it a step further, why not just use
> kernel/debug.S for the decompresser and replace much of the code in
> compressed/head.S. This would get rid of 2 implementations of DCC, SA1100 and
> S3C2410 code.
> 
> Am I missing something?

I've been looking forward to do exactly that. Didn't get around to it 
yet, so if you feel like doing that work then please go ahead and I'll 
be glad to review it.


Nicolas
