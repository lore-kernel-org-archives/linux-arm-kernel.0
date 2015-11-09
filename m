From: hare@suse.de (Hannes Reinecke)
Date: Mon, 09 Nov 2015 08:15:40 +0100
Subject: [PATCH V2 3/3] scsi: mptxsas: offload IRQ execution
In-Reply-To: <1447034266-28003-4-git-send-email-okaya@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-4-git-send-email-okaya@codeaurora.org>
Message-ID: <5640481C.9000505@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2015 02:57 AM, Sinan Kaya wrote:
> The mpt2sas and mpt3sas drivers are spinning forever in
> their IRQ handlers if there are a lot of jobs queued up
> by the PCIe card. This handler is causing spikes for
> the rest of the system and sluggish behavior.
> 
> Marking all MSI interrupts as non-shared and moving the
> MSI interrupts to thread context. This relexes the rest
> of the system execution.
> 
NACK.

If there is a scalability issue when handling interrupts
it should be fixed in the driver directly.

Looking at the driver is should be possible to implement
a worker thread handling the reply descriptor, and having the
interrupt only to fetch the reply descriptor.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
