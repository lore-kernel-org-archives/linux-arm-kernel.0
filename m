From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Nov 2012 21:45:05 +0000
Subject: Branches next/soc and for-next
In-Reply-To: <50B7BF41.7060807@broadcom.com>
References: <50B7BF41.7060807@broadcom.com>
Message-ID: <201211292145.05481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 November 2012, Markus Mayer wrote:
> 
> Hi Arnd and Olof,
> 
> Following a short discussion with Pawel regarding a build breakage in 
> next/soc (see 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/thread.html#135208), 
> I would like to ask you for some clarification as to the differences 
> between the branches next/soc and for-next and what that means for 
> development.
> 
> If I understand correctly, next/soc is being used to integrate SoC work 
> from various board- or vendor-specific branches. for-next, in turn, 
> integrates next/soc with driver branches and other non-SoC related 
> branches. Is this somewhat accurate? 

Yes, this is exactly correct.

> -- What happens to code in 
> for-next? Is that what eventually gets pulled into mainline?

The for-next branch contains a lot of merges between all the other next/*
branches. The individual branches get sent in the next merge window,
but the for-next branch does not. Linus does all the merges himself.
 
> As I mentioned in my discussion with Pawel, next/soc currently doesn't 
> build for vexpress and, since vexpress is multiplatform-enabled, no 
> other multiplatform target will build, either. The reason for this, 
> Pawel explained, was that he was asked to split his patch, so it could 
> be applied to different branches, depending on the subsystem area his 
> changes were made in. As a result, a file needed for compilation 
> (arch/mach-vexpress/reset.c) is missing in next/soc.

This is a mistake that should not have happened.

> How are such build errors generally addressed? How long does it usually 
> take?

If you have a fix, then we will usually integrate it within days. The
problem is that we normally don't test the individual branches and
to some degree trust that the branches we get are ok.

The normal way to address this problem is by documenting the dependencies
between branches that get pulled into the arm-soc tree.

> And, lastly, which branch would you recommend to use for 
> development to generate patches relative to arm-soc?

You don't. All branches that get submitted into arm-soc should be
working by themselves and just be based on a -rc release from Linus.
When that is not possible, e.g. when you have dependencies like
the one you mention, you can base one branch you send on another one
that is already part of arm-soc. Don't base on a complete next/*
branch though, but rather take the minimal set of dependencies.

Also, try not to rebase your branch before submitting it, to make
sure that the testing you did is still valid.

	Arnd
