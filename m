From: joe@perches.com (Joe Perches)
Date: Thu, 24 May 2012 10:40:29 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <4FBE6FF6.5090904@zytor.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <1337880371.5070.24.camel@joe2Laptop> <4FBE6FF6.5090904@zytor.com>
Message-ID: <1337881229.5070.29.camel@joe2Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-05-24 at 10:29 -0700, H. Peter Anvin wrote:
> On 05/24/2012 10:26 AM, Joe Perches wrote:
> > On Thu, 2012-05-24 at 10:03 -0600, T Makphaibulchoke wrote:
> >> The patch cleans up the file lib/decompress_unxz.c by removing all memory
> >> helper functions, e.g., memmove.  By doing so, any architecture's preboot
> >> environment supporting the XZ decompression needs to define its own copy of
> >> any of the missing memory helper functions.
> > 
> > Perhaps a silly question, but why not use
> > the __builtin variants?
> 
> For a lot of cases the __builtin variants just generate a call to the
> expected out-of-line function, so you need it anyway.

While I'm not completely knowledgeable about gcc,
aren't all the __builtin_mem<foo> functions always
available in gcc 3+

http://gcc.gnu.org/onlinedocs/gcc-3.0.4/gcc_5.html#SEC114

It does say:

Many of these functions are only optimized in certain cases; if not
optimized in a particular case, a call to the library function will be
emitted.
