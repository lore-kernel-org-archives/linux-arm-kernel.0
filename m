From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 31 Aug 2012 11:38:52 -0400
Subject: [PATCH] ARM: Kirkwood: Fix 'SZ_1M' undeclared here for
 db88f6281-bp-setup.c
In-Reply-To: <20120831054734.GA30111@lunn.ch>
References: <1346305152-14618-1-git-send-email-andrew@lunn.ch>
 <20120830171236.GS19437@titan.lakedaemon.net>
 <20120830180853.GP9886@lunn.ch>
 <20120830185050.GZ19437@titan.lakedaemon.net>
 <20120831054734.GA30111@lunn.ch>
Message-ID: <20120831153852.GG19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 07:47:34AM +0200, Andrew Lunn wrote:
> On Thu, Aug 30, 2012 at 02:50:50PM -0400, Jason Cooper wrote:
> > On Thu, Aug 30, 2012 at 08:08:53PM +0200, Andrew Lunn wrote:
> > > On Thu, Aug 30, 2012 at 01:12:36PM -0400, Jason Cooper wrote:
> > > > On Thu, Aug 30, 2012 at 07:39:12AM +0200, Andrew Lunn wrote:
> > > > > Linux-next has failed to compile for kirkwood since 23 August with:
> > > > > 
> > > > > arch/arm/mach-kirkwood/db88f6281-bp-setup.c:29: error: 'SZ_1M' undeclared here (not in a function)
> > > > > arch/arm/mach-kirkwood/db88f6281-bp-setup.c:33: error: 'SZ_4M' undeclared here (not in a function)
> > > > > 
> > > > > Add missing <linux/sizes.h>
> > > > > 
> > > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > 
> > > > Applied to: fixes-for-v3.6
> > > > 
> > > > Also, I added a CC for stable so greg can pick it up.
> > > 
> > > Stable does not need it. As i said, it only broke 23 August with
> > > linux-next. So this is needed for only 3.7.
> > 
> > Do we know caused the break?  Is it a fix destined for -stable?
> 
> Hi Jason
> 
> If im groking the output from gcc -E correctly, it was this change:
> 
> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=8f039ba3191e67bf48e560f5737d0c285720d4d8
> 
> The #include <asm/memory.h> has been dropped, and its from there that
> it was getting <linux/sizes.h>.
> 
> This does not look like a change that will get backported to anything
> earlier than 3.7.

Ok, Arnd and Olof haven't pulled yet, so I'll issue a new request
without the Cc -stable.

thx,

Jason.
