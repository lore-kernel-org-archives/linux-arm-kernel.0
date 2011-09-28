From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Sep 2011 15:00:30 +0200
Subject: at91 material for 3.1
In-Reply-To: <4E82DA79.70006@atmel.com>
References: <4E82DA79.70006@atmel.com>
Message-ID: <201109281500.30189.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 September 2011, Nicolas Ferre wrote:
> I have two little patches about Kconfig and one defconfig that are
> suitable for a 3.1 inclusion.
> 
> I wonder if you plan a pull request to Linus before 3.1-final?
> 
> If yes, would you prefer each patch in a feature branch on its own
> (at91-kconfig, at91-defconfig for instance) or a generic at91-fixes?

If you have updates that should go into the current release, they should
be bug fixes of some sort, so a single "fixes" branch is good for those.

Just send a pull request so I can add them to the common fixes branch
in the arm-soc tree. I generally send everything in there to Linus when
there is a significant amount of it, or when significant time has passed
since I sent the previous pull request or when there is something urgent
in the tree.

>From your description, it sounds like it's not urgent but I that it's
still appropriate for 3.1. Remember that when you send bug fixes I
want to have a short statement how important the patches are, roughly
listing them as one of 

1. regression: it's broken in this version without the fix, and the
   previous release was ok.
2. stable backport: the problem has been around for some time and
   the bug fix should be applied to all older kernels as well.
   (add a line "Cc: stable at kernel.org" below your Signed-off-by
   in that case)
3. bug in new code: some new feature was merged in this window
   and a bug was found in it.
4. minor bug fix: can wait for the next merge window, e.g. incorrect
   debug output or nonoptimial defconfigs.

	Arnd
