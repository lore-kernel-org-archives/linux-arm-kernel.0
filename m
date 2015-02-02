From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 02 Feb 2015 22:12:40 +0300
Subject: [PATCH v3] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_SMART PIO mode command.
In-Reply-To: <1422900439-5541-2-git-send-email-stripathi@apm.com>
References: <1422900439-5541-1-git-send-email-stripathi@apm.com>
 <1422900439-5541-2-git-send-email-stripathi@apm.com>
Message-ID: <54CFCC28.6050609@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/02/2015 09:07 PM, Suman Tripathi wrote:

> This patch addresses the issue with ATA_CMD_SMART pio mode
> command for enumeration and device detection with ATA devices.
> The X-Gene AHCI controller has an errata in which it cannot clear
> the BSY bit after the PIO setup FIS. The dma state machine enters

    Hum, if this happens after every PIO command (PIO setup FISes are not 
specific to the command, right?), perhaps it would make more sense to record 
the *protocol* used by the last command?

> CMFatalErrorUpdate state and locks up. It is the same issue as
> in the commit 2a0bdff6b958d1b2523d2754b6cd5e0ea4053016 (ahci-xgene:
> fix the dma state machine lockup for the IDENTIFY DEVICE PIO mode
> command).

> For example :  without this patch it results in READ DMA command failure
> as shown below :

[...]

> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> Reported-by:   Mark Langsdorf <mlangsdo@redhat.com>

MBR, Sergei
