From: robherring2@gmail.com (Rob Herring)
Date: Fri, 27 May 2011 13:10:14 -0500
Subject: uncompress and ll debug uart consolidation
Message-ID: <4DDFE906.9020101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I started looking at the 10 duplicate implementations of PL01x uart code 
in various mach/uncompress.h. My first thought was just consolidate 
those into 1 uncompress-pl01x.h header similar to debug-pl01x.S.

However, the LL debug macros are basically doing the same thing and are 
already used by compressed/head.S, so why not make the uncompress code 
use them? The debug macros are already included when DEBUG is defined 
for compressed/head.S. It's quite trivial to use putc from head.S in 
misc.c instead of the C version. To take it a step further, why not just 
use kernel/debug.S for the decompresser and replace much of the code in 
compressed/head.S. This would get rid of 2 implementations of DCC, 
SA1100 and S3C2410 code.

Am I missing something?

Rob
