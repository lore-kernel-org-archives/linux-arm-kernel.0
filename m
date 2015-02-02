From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 02 Feb 2015 20:07:53 +0300
Subject: [PATCH v2] ahci_xgene: Fix the dma state machine lockup for the
 ATA_CMD_SMART PIO mode command.
In-Reply-To: <1422878229-20488-2-git-send-email-stripathi@apm.com>
References: <1422878229-20488-1-git-send-email-stripathi@apm.com>
 <1422878229-20488-2-git-send-email-stripathi@apm.com>
Message-ID: <54CFAEE9.30002@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/02/2015 02:57 PM, Suman Tripathi wrote:

> This patch addresses the issue with ATA_CMD_SMART pio mode
> command for enumeration and device detection with ATA devices.
> The X-Gene AHCI controller has an errata in which it cannot clear
> the BSY bit after the PIO setup FIS. The dma state machine enters
> CMFatalErrorUpdate state and locks up. It is the same issue as
> in the commit 2a0bdff6b958d1b2523d2754b6cd5e0ea4053016(fix the

    You forgot a space before '('.

> dma state machine lockup for the IDENTIFY DEVICE PIO mode
> command).

    Actually, the summary is "ahci_xgene: fix the dma state machine lockup for 
the IDENTIFY DEVICE PIO mode command.", i.e. yours is missing a prefix.

[...]

> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> Reported-by:   Mark Langsdorf <mlangsdo@redhat.com>

MBR, Sergei
