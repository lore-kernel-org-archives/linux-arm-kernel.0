From: tj@kernel.org (Tejun Heo)
Date: Thu, 19 Jun 2014 10:10:47 -0400
Subject: [PATCH v3 2/2] ata: Fix the dma state machine lockup for the
 IDENTIFY DEVICE PIO mode command.
In-Reply-To: <1403160654-31612-1-git-send-email-stripathi@apm.com>
References: <1403160654-31612-1-git-send-email-stripathi@apm.com>
Message-ID: <20140619141047.GA26904@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 12:20:54PM +0530, Suman Tripathi wrote:
> +	/*
> +	 * Restart the dma engine if the last cmd issued
> +	 * is IDENTIFY DEVICE command
> +	 */
> +	if (unlikely(ctx->last_cmd[ap->port_no] == ATA_CMD_ID_ATA))
> +		ahci_restart_engine(ap);

Is it really only for IDENTIFY?  Are other PIO commands okay?  The
previous version applied it to all PIO commands, right?

-- 
tejun
