From: dan.j.williams@intel.com (Dan Williams)
Date: Sun, 28 Feb 2010 21:36:33 -0700
Subject: [PATCH 6/7] fix COH 901 318 memcpy and slave issues
In-Reply-To: <1266537963-13368-1-git-send-email-linus.walleij@stericsson.com>
References: <1266537963-13368-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <e9c3a7c21002282036w4f627bbdibcdadb9b493ef19@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2010 at 5:06 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This patch fixes several issues with the COH 901 318 DMA engine:
>
> - A questionable mechanism for counting the number of interrupts
> ?was removed. There is never more than one interrupt fired for
> ?a transaction in this hardware.
> - A debug print was broken to the point that it caused a bug
> ?when swithed on.
> - Dynamically configure the slave controller for mem->dev
> ?or dev->mem transfers, this was previously hard-coded in
> ?the channel configurations, but we have a channel which
> ?is actually bidirectionals (MMC/SD) so this doesn't work
> ?out!
> - Refactored a bit to get a clearer program flow especially in
> ?the dma_tasklet() and also remove some duplicated code, minor
> ?nitwits, spelling etc.
> - Also removed the redundant BUG_ON() located by Julia Lawall
> ?using coccinelle.
>

Sorry for the delay.  This looks ok to me as far as I can tell, but it
makes me a bit nervous to make all the unrelated changes in one
commit.  For bisection purposes I think it would be better to split
the pure cleanups from the fixes, agree?

I may proceed with the initial dmaengine pull request as early as
tomorrow, but I think this is something that we can justify later in
the merge window or even shortly after -rc1.

--
Dan
