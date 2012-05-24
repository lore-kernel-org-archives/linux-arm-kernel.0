From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 24 May 2012 10:29:26 -0700
Subject: [PATCH] lib/decompress_unxz.c: removing all memory helper
 functions
In-Reply-To: <1337880371.5070.24.camel@joe2Laptop>
References: <1337875436-27640-1-git-send-email-tmac@hp.com>
 <1337880371.5070.24.camel@joe2Laptop>
Message-ID: <4FBE6FF6.5090904@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2012 10:26 AM, Joe Perches wrote:
> On Thu, 2012-05-24 at 10:03 -0600, T Makphaibulchoke wrote:
>> The patch cleans up the file lib/decompress_unxz.c by removing all memory
>> helper functions, e.g., memmove.  By doing so, any architecture's preboot
>> environment supporting the XZ decompression needs to define its own copy of
>> any of the missing memory helper functions.
> 
> Perhaps a silly question, but why not use
> the __builtin variants?

For a lot of cases the __builtin variants just generate a call to the
expected out-of-line function, so you need it anyway.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
