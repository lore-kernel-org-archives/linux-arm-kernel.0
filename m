From: rob@landley.net (Rob Landley)
Date: Mon, 23 Sep 2013 21:13:20 -0500
Subject: new binutils needed for arm in 3.12-rc1
In-Reply-To: <20130923235917.GA30967@amd.pavel.ucw.cz> (from pavel@ucw.cz on
 Mon Sep 23 18:59:17 2013)
Message-ID: <1379988800.1974.68@driftwood>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/23/2013 06:59:17 PM, Pavel Machek wrote:
> During 3.12-rc, Will Deacon introduced code into arch/arm that
> requires binutils 2.22.

Um, my toolchain is using the last gplv2 snapshot of binutils out of  
git, which is just past 2.17 and can build armv7 (but not armv8).

Binutils 2.12->2.22 is quite the jump. (11 years.) I'd except some  
thought to have gone into that? Possibly a mention of it?

> diff --git a/Documentation/Changes b/Documentation/Changes
> index b175808..0f8deaf 100644
> --- a/Documentation/Changes
> +++ b/Documentation/Changes
> @@ -23,7 +23,7 @@ you probably needn't concern yourself with  
> isdn4k-utils.
> 
>  o  Gnu C                  3.2                     # gcc --version
>  o  Gnu make               3.80                    # make --version
> -o  binutils               2.12                    # ld -v
> +o  binutils               2.22                    # ld -v

When the sh4 platform did this, I just reverted the patch. (It still  
reverts cleanly ~4 years later, and builds with my old tool versions...)

Rob
