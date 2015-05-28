From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 May 2015 10:49:46 +0200
Subject: [PATCH 2/3] Revert "bus: mvebu-mbus: make sure SDRAM CS for DMA
 don't overlap the MBus bridge window"
In-Reply-To: <1432802414-12355-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1432802414-12355-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1432802414-12355-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <2099675.EoA8CYtzXr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 May 2015 10:40:13 Thomas Petazzoni wrote:
> Fixes: 1737cac69369 ("bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window")
> Cc: <stable@vger.kernel.org> # v4.0+
> ---
>  drivers/bus/mvebu-mbus.c | 105 ++++++++---------------------------------------
>  1 file changed, 16 insertions(+), 89 deletions(-)

Hmm, the stable kernel rules say that a patch cannot exceed 100
lines with context, so this one is technically too large.

Maybe Greg has a suggestion about what to do here. Is it possible
to make an exception for a revert? In theory you could make a
smaller version of the patch that adds an #if 0 instead of removing
some of the code that was added, in order to get below the limit,
but that seems counterproductive for minimizing the possible risk.

	Arnd
