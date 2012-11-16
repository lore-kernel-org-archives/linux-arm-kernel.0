From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Nov 2012 08:16:50 +0000
Subject: Additional updates for armsoc-3.8
In-Reply-To: <1353033963.11943.2.camel@gitbox>
References: <1353033963.11943.2.camel@gitbox>
Message-ID: <201211160816.50271.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 November 2012, Tony Prisk wrote:
> Quick question,
> 
> If I want to send further patches to armsoc for 3.8, should I write them
> on top of the already pulled patches, or start from clean 3.7-rc?
> 
> I know you like to pull from a -rc, but these changes are to add the
> WM8850 support, and will change the already changed files from the
> previous pull.

(adding Cc to linux-arm-kernel, I hope you don't mind and this is probably
of interest to other people as well)

If it's easy to do, you should start from a fresh -rc. In this case, it
sounds like it makes sense to start from the previously pulled branch.
No problem there in principle, just mind the ordering of topics:

When you check out the arm-soc tree, you can find a file named
arch/arm/arm-soc-for-next-contents.txt that lists all the next/*
branches and what has been pulled into them. The branches are
roughly in order and sometimes have dependencies between them
that are documented.

In this case, you have contents in two branches, next/cleanup and
next/multiplatform. If you want to submit another branch on top of this,
the main requirement is that it can't go into a branch that I want to
submit first (which would be "fixes-non-critical" or "headers". Support
for a new soc would likely go into the "soc" branch, which comes after
"cleanup" and "multiplatform", so there is no problem here.

The specific set of branches and their order is usually similar from
one release to the next, but not always the same, because it depends on
what kind of changes we get during the cycle.

	Arnd
