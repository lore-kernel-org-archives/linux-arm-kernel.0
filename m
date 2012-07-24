From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 12:00:10 +0000
Subject: [GIT PULL 00/15] arm-soc: changes for v3.6
In-Reply-To: <20120724081246.GS6522@atomide.com>
References: <1343075561-17446-1-git-send-email-arnd@arndb.de>
 <201207240751.39111.arnd@arndb.de> <20120724081246.GS6522@atomide.com>
Message-ID: <201207241200.11190.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Tony Lindgren wrote:
> > I spent too much time fiddling with my scripts again in an attempt to
> > get closer to the regular git-request-pull version. The older version
> > got this right, but unfortunately I removed the part where I manually
> > print the right pull address because that had caused other problems
> > before.
> 
> FYI, this issue happens also with git request-pull if the tag has not
> yet gotten mirrored but the branch is already mirrored.

In this case it they were both there, but it picked up the branch
anyway. I actually made sure that the tag description was included
by git-request-pull, and the tag has a different name from the
branch (no "next/" prefix), but the tool is not does not attempt
to pick up the tag rather than the branch when both are available.

Apparently, the problem is that it treats the branch "next/foo"
as as exact match for a pull request on the "foo" tag even when
that tag is present as "foo" on the server. If I either name the
branch or the tag differently, or pass "tags/foo" as the
argument to git-request-pull, it reports back the tag instead.

	Arnd
