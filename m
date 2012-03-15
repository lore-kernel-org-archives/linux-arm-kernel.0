From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 20:01:12 +0000
Subject: linux-next: manual merge of the arm-soc tree with Linus' tree
In-Reply-To: <1362815.uO65s14ojU@avalon>
References: <20120315175000.897f1172c296d4a687be0537@canb.auug.org.au>
 <1362815.uO65s14ojU@avalon>
Message-ID: <201203152001.12353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 March 2012, Laurent Pinchart wrote:
> The following patch (5d7220ec000f rebased on top of 1740d3448012) shows the
> correct conflict resolution in my opinion.
> 
> From f040ba69632a54c86767974768d68b308901061c Mon Sep 17 00:00:00 2001
> From: Magnus Damm <damm@opensource.se>
> Date: Wed, 29 Feb 2012 12:37:19 +0900
> Subject: [PATCH] ARM: mach-shmobile: sh7372 map_io and init_early update
> 
> ARM: mach-shmobile: sh7372 map_io and init_early update
> 
> Update the sh7372 SoC and the AP4EVB and Mackerel boards to make use
> of the functions sh7372_map_io() and sh7372_add_early_devices().
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Laurent,

I've merged Paul's branch into my renesas/soc branch, because I don't
rebase the branches once they are merged into arm-soc. Thanks a lot
for the resolution you suggested, I used the same resulting code
in the merge commit.

I'm not particularly happy about how we got here. Obviously, the bug
fixes that Paul sent should have gone through the arm-soc tree to
avoid this situation, and they should have been based on a -rc release
rather than some random commit after -rc6. It's not a big issue
because the next/soc branch already contains -rc7 though.

	Arnd
