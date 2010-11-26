From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 26 Nov 2010 20:46:54 +0100
Subject: [PATCH] MMC: Fix multiblock SDIO transfers in AT91 MCI
In-Reply-To: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
References: <1290679911-5992-1-git-send-email-yauhen.kharuzhy@promwad.com>
Message-ID: <20101126194654.GI26540@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:11 Thu 25 Nov     , Yauhen Kharuzhy wrote:
> The AT91 MCI has special SDIO transfer types: SDIO block and SDIO byte
> transfers, but at91_mci driver doesn't use them and handles all SDIO
> transfers as ordinary MMC block transfers. This causes problems for
> multiple-block SDIO transfers (in particular for 256-bytes blocks).
> 
> Fix this situation by check opcode for SDIO CMD53 and set transfer
> type in AT91_MCI_CMDR register properly.
> 
> This patch was tested with libertas SDIO driver: problem with TX
> timeouts on big packets was eliminated.
> 
> Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
