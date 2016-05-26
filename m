From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 25 May 2016 20:10:05 -0700
Subject: [PATCH 1/2] Revert "mtd: atmel_nand: Support variable RB_EDGE
 interrupts"
In-Reply-To: <20160523095557.1efea63d@bbrezillon>
References: <1462776680-5284-1-git-send-email-wenyou.yang@atmel.com>
 <1462776680-5284-2-git-send-email-wenyou.yang@atmel.com>
 <20160523095557.1efea63d@bbrezillon>
Message-ID: <20160526031005.GA137092@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 23, 2016 at 09:55:57AM +0200, Boris Brezillon wrote:
> On Mon, 9 May 2016 14:51:18 +0800
> Wenyou Yang <wenyou.yang@atmel.com> wrote:
> 
> > This reverts commit 5ddc7bd43ccc ("mtd: atmel_nand: Support variable
> > RB_EDGE interrupts")
> > 
> > Because for current SoCs, the RB_EDGE3(i.e. bit 27) of HSMC_SR
> > register does not exist, the RB_EDGE0 (i.e. bit 24) is the ready/busy
> > line edge status bit. It is a datasheet bug.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> 
> Wenyou, I know you sent it before v4.6 was released, but now we should
> probably add

Sorry for the delay...

> Cc: <stable@vger.kernel.org>

Added that and a Fixes: tag.

> Brian, can you apply this patch directly in your tree (as previously
> discussed, I'm not sure creating a nand/fixes branch is really useful)?

Pushed to linux-mtd.git. I'll probably send it to Linus in the next day
or two.

Brian
