From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Feb 2013 18:23:44 +0000
Subject: [PATCH] ARM: Dove: fix build breakage with .timer/.init_time
In-Reply-To: <1361043816-28753-1-git-send-email-jason@lakedaemon.net>
References: <1361043816-28753-1-git-send-email-jason@lakedaemon.net>
Message-ID: <201302171823.44808.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Jason Cooper wrote:
> In the latest arm-soc/for-next, building dove_defconfig breaks because
> .timer has been replaced with .init_timer in DT_MACHINE_START.  With
> this fix, it builds fine.

When I look at arm-soc/for-next, there is no arch/arm/mach-dove/board-dt.c
file, so it currently builds cleanly and the problem is only when merging
your branch with the arm-soc/timer/cleanup branch.

This is not hard to fix, and there are two ways that work equally well,
just pick one that works for you:

* rebase your branch on top of the arm-soc/timer/cleanup branch and let
  us know about the dependency when you send a pull request for it.

* if you don't want to rebase your branch, pull arm-soc/timer/cleanup
  into it and do this change in the merge changeset, noting it down
  in the changeset description. As above, when you send such a branch,
  let us know of the dependency.

If the branch with the merge problem is destined for 3.10, the timer
cleanups will already be in there, so you can simply base on them
now and don't need to track the dependencies.

	Arnd
