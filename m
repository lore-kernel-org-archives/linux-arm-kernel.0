From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Jun 2015 23:32:58 +0100
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <1434491507-6208-1-git-send-email-stefan@agner.ch>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
Message-ID: <20150616223258.GW7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 11:51:47PM +0200, Stefan Agner wrote:
> Add early fixmap support, initially to support permanent, fixed
> mapping support for early console. A temporary, early pte is
> created which is migrated to a permanent mapping in paging_init.
> This is also needed since the attributes may change as the memory
> types are initialized. The 3MiB range of fixmap spans two pte
> tables, but currently only one pte is created for early fixmap
> support.
> 
> Re-add FIX_KMAP_BEGIN to the index calculation in highmem.c since
> the index for kmap does not start at zero anymore. This reverts
> 4221e2e6b316 ("ARM: 8031/1: fixmap: remove FIX_KMAP_BEGIN and
> FIX_KMAP_END") to some extent.

Sorry, this isn't going to make the next merge window, I've closed my
tree at the end of last week to new submissions (because it got too
painful to maintain the for-next branch due to the number of cross-
dependencies between branches.)  The only patches I'll entertain this
week and throughout the merge window are bug fixes.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
