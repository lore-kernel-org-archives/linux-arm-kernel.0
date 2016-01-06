From: stripathi@apm.com (Suman Tripathi)
Date: Wed, 6 Jan 2016 19:20:26 +0530
Subject: [PATCH 0/2] ata: Introduce the AHCI_HFLAG_EDGE_IRQ_BROKEN in
 libahci and enabling it for ahci_xgene driver.
In-Reply-To: <1450942289-12660-1-git-send-email-stripathi@apm.com>
References: <1450942289-12660-1-git-send-email-stripathi@apm.com>
Message-ID: <CAOHikRAMhdGuqYsajJPD0e+iSVtYn4Ymxc7sR7WdN_1mo_x_bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Happy new  year !!

Any comments on this patchset ?

On Thu, Dec 24, 2015 at 1:01 PM, Suman Tripathi <stripathi@apm.com> wrote:
> This patch set implements a workaround for an errate in the APM
> X-Gene SATA host controller with edge interrupt. The HOST_IRQ_STAT
> misses the edge interrupt from the PORT_IRQ_STAT when clearing the
> HOST_IRQ_STAT and reporting the PORT_IRQ_STAT happens in same clock
> cycle.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>
> Suman Tripathi (2):
>   libahci: Implement the workaround to fix the missing of edge
>     interrupt for HOST_IRQ_STAT
>   ahci_xgene: Enable AHCI_HFLAG_EDGE_IRQ_BROKEN for APM X-Gen2 SATA
>     host controller
>
>  drivers/ata/ahci.h       |    2 ++
>  drivers/ata/ahci_xgene.c |    3 ++-
>  drivers/ata/libahci.c    |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 1 deletions(-)
>



-- 
Thanks,
with regards,
Suman Tripathi
