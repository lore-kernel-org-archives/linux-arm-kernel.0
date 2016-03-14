From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:34:55 +0100
Subject: [PATCH 08/22] ncr5380: Use DMA hooks for PDMA
In-Reply-To: <20160314042702.716014118@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042702.716014118@telegraphics.com.au>
Message-ID: <56E6699F.2050401@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> Those wrapper drivers which use DMA define the REAL_DMA macro and
> those which use pseudo DMA define PSEUDO_DMA. These macros need to be
> removed for a number of reasons, not least of which is to have drivers
> share more code.
> 
> Redefine the PDMA send and receive hooks as DMA setup hooks, so that the
> DMA code can be shared by all 5380 wrapper drivers. This will help to
> reunify the forked core driver.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c      |   10 ++--------
>  drivers/scsi/arm/cumana_1.c |   10 ++++++----
>  drivers/scsi/arm/oak.c      |   10 ++++++----
>  drivers/scsi/dmx3191d.c     |    4 ++--
>  drivers/scsi/dtc.c          |    6 ++++--
>  drivers/scsi/dtc.h          |    2 ++
>  drivers/scsi/g_NCR5380.c    |   10 ++++++----
>  drivers/scsi/g_NCR5380.h    |    4 ++--
>  drivers/scsi/mac_scsi.c     |    5 ++---
>  drivers/scsi/pas16.c        |   14 ++++++++------
>  drivers/scsi/pas16.h        |    2 ++
>  drivers/scsi/t128.c         |   12 ++++++------
>  drivers/scsi/t128.h         |    2 ++
>  13 files changed, 50 insertions(+), 41 deletions(-)
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
