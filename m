From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:28:09 +0100
Subject: [PATCH 06/22] ncr5380: Remove PSEUDO_DMA macro
In-Reply-To: <20160314042702.216030077@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042702.216030077@telegraphics.com.au>
Message-ID: <56E66809.7090100@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> For those wrapper drivers which only implement Programmed IO, have
> NCR5380_dma_xfer_len() evaluate to zero. That allows PDMA to be easily
> disabled at run-time and so the PSEUDO_DMA macro is no longer needed.
> 
> Also remove the spin counters used for debugging pseudo DMA drivers.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c      |   32 +-------------------------------
>  drivers/scsi/NCR5380.h      |    4 ----
>  drivers/scsi/arm/cumana_1.c |    2 --
>  drivers/scsi/arm/oak.c      |    3 +--
>  drivers/scsi/dmx3191d.c     |    4 ++++
>  drivers/scsi/dtc.c          |    7 -------
>  drivers/scsi/dtc.h          |    2 --
>  drivers/scsi/g_NCR5380.c    |    1 -
>  drivers/scsi/g_NCR5380.h    |    1 -
>  drivers/scsi/mac_scsi.c     |   10 ----------
>  drivers/scsi/pas16.c        |   10 ----------
>  drivers/scsi/pas16.h        |    2 --
>  drivers/scsi/t128.c         |    4 ----
>  drivers/scsi/t128.h         |    2 --
>  14 files changed, 6 insertions(+), 78 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
