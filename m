From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 1 Aug 2014 16:09:57 +0200
Subject: [PATCH] asm-generic/io.h: reorder funtions to form logical groups
In-Reply-To: <20140719125937.GA18566@ravnborg.org>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <20140718205953.GA21964@ravnborg.org>
 <20140719125937.GA18566@ravnborg.org>
Message-ID: <20140801140956.GA1913@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 19, 2014 at 02:59:37PM +0200, Sam Ravnborg wrote:
> From 929c64c1aaf378b767e0ed89826b6bb12449df15 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 19 Jul 2014 14:47:43 +0200
> Subject: [PATCH] asm-generic/io.h: reorder funtions to form logical groups
> 
> Reoder the functions so the various functions are grouped
> according to how they access memoy.
> For example __raw_{read,write}* are now all grouped.
> 
> The benefit of this grouping is that one can easier find all
> IO accessors of one type.
> To do so a few more #ifdef CONFIG_64BIT had to be used.
> 
> Add a small boiler plate comment for some of the groups to
> better let them stand out.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> Hi Thierry.
> 
> This is my attempt to bring some order into io.h
> with respect to the order the functions are defined in.
> 
> In a follow-up mail I also said we should delete the _p variants
> of some methods but I then learned they are for slow IO access.
> So these I have left as is.
> 
> And introducing static inline for all functions that are pure macro
> substitution is also left out for now.
> 
> Please consider if you will take this as a follow-on patch.

Just a short update on this: I've pulled your patch into my series and
then thought I'd make a last pass over these and send out a new version
but then I started noticing a few more things that I thought I could
quickly clean up as well. One thing led to another and I'm now up to
double the number of patches. I still think it's worth doing, but
unfortunately it's become somewhat more complicated since it now touches
a couple more architectures and even some drivers (/dev/mem (!) and
sunzilog).

I'm almost through sorting out the remaining issues I think, but it'll
take me another couple of days to rebase and squash patches and run some
build tests to verify that things don't break somewhere in the middle.

Oh, by the way: would you prefer that I keep your patch separate or
shall I just squash it into the one that has the major asm-generic/io.h
cleanup?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140801/ba0aea4e/attachment.sig>
