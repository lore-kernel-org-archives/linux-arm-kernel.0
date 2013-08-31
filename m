From: joe@perches.com (Joe Perches)
Date: Sat, 31 Aug 2013 09:04:09 -0700
Subject: [PATCH] checkpatch:  Add test for positional misuse of section
 specifiers like __initdata
In-Reply-To: <20130831143123.GC19750@two.firstfloor.org>
References: <1377655732.3619.19.camel@joe-AO722>
 <20130831143123.GC19750@two.firstfloor.org>
Message-ID: <1377965049.2054.15.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2013-08-31 at 16:31 +0200, Andi Kleen wrote:
> > A similar patch was suggested by Andi Kleen
> > https://lkml.org/lkml/2013/8/5/648
> 
> My patch checked for const <-> initdata / non const initconst  mistakes.
> 
> I don't think your patch does that?

Hi Andi.

No it doesn't.

This patch is just warning when using
	struct __initdata foo bar;
instead of
	struct foo bar __initdata;

I'll get around to adding tests for your
cases soonish.

cheers, Joe
