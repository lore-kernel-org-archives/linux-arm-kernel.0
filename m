From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 28 May 2012 09:03:36 +0200
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1337875436-27640-1-git-send-email-tmac@hp.com>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
Message-ID: <20120528070336.GM3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:03 Thu 24 May     , T Makphaibulchoke wrote:
> The patch cleans up the file lib/decompress_unxz.c by removing all memory
> helper functions, e.g., memmove.  By doing so, any architecture's preboot
> environment supporting the XZ decompression needs to define its own copy of
> any of the missing memory helper functions.
> 
> The patch makes sure that all 4 architectures' preboot currently supporting
> the XZ decompressor, arm, s390, sh and x86, build without error when using
> the XZ compression.
> 
> Adding a prototype for the memcmp function required by the XZ decompressor to
> workaround compiler's implicit type error.  Also removing both the memmove and
> memcpy defines workaround, to disable lib/decompress_unxz.c from duplicating
> both functions.
> 
> Adding the missing memcmp function, required by the XZ decompressor, to the
> s390 preboot environment.
> 
> Adding both the missing memmove and memcmp functions, required by the XZ
> decompressor, to the sh preboot environment.
> 
> Adding the missing memmove function, required by XZ decompressor, to the x86
> preboot environment.
> 
> Signed-off-by: T. Makphaibulchoke <tmac@hp.com>
> ---
>  arch/arm/boot/compressed/decompress.c |    3 +-
>  arch/s390/boot/compressed/misc.c      |   14 +++++
>  arch/sh/boot/compressed/misc.c        |   32 ++++++++++++
>  arch/x86/boot/compressed/string.c     |   18 +++++++a
can we do not duplicate those functions?

Best Regards,
J.
