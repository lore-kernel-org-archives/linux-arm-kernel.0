From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 23:08:53 +0000
Subject: [PATCH v3 0/8] Add support for tegra30 and cardhu
In-Reply-To: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320675617-20751-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111107230853.GW12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 04:20:07PM +0200, Peter De Schrijver wrote:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.
> 
> Pathset is on top of Will Deacon's ARM reset work.

Note that there's another solution for the arch_reset() stuff floating
around (mine) which goes a tad further than Will's, specifically avoiding
the problems of having multiple function pointers for this stuff.

My version also cleans up the use of the identity mappings for non-soft
restarts, which is going to be needed to fix soft-restarts on ARMv6+v7
properly (as well as migrating all the soft-restart support to something
a little saner.)
