From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 6 Aug 2012 14:02:22 +0000
Subject: [PATCH 0/6] ARM: dove: DT support for Marvell Dove
In-Reply-To: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1344255815-4457-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <201208061402.22815.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 06 August 2012, Sebastian Hesselbarth wrote:
> This patch set adds DT support for Marvell Dove SoC and three boards
> equipped with this SoC. The work is based on device tree support for
> Marvell Orion based SoCs introduced in 3.6-rc1.
> 
> The first three patches move mach-dove closer to Marvell Kirkwood's
> setup code by unifying the clock setup routines, adding clock gating
> control, and support for Marvell's crypto engine to mach-dove.
> 
> Patches 4 and 5 add a generic DT machine descriptor to mach-dove and
> corresponding DT descriptors for the SoC and already supported boards.
> 
> Finally, the last patch adds a DT descriptor for the SolidRun CuBox,
> a plug computer based on Marvell Dove.
> 
> This patch set relies on a DT support patch for sdhci-dove that has
> been sent to the corresponding maintainers a few days ago.

This looks vert nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Has anyone tested it on cm-a510 and dove-db? Once we can reasonably
assume that there are no regressions compared to using the board
files, I think we can plan for removing the non-DT support in
mach-dove. If it's been tested positively, that can well be at
the same time as adding the DT support, otherwise I think we should
wait a couple of releases while having both simultaneously.

	Arnd
