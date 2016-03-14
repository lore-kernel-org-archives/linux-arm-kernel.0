From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:38:26 +0100
Subject: [PATCH 10/22] ncr5380: Merge DMA implementation from
 atari_NCR5380 core driver
In-Reply-To: <20160314042703.226339838@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042703.226339838@telegraphics.com.au>
Message-ID: <56E66A72.8090906@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> Adopt the DMA implementation from atari_NCR5380.c. This means that
> atari_scsi and sun3_scsi can make use of the NCR5380.c core driver
> and the atari_NCR5380.c driver fork can be made redundant.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c      |  170 +++++++++++++++++++++++++++++++++++---------
>  drivers/scsi/arm/cumana_1.c |    3 
>  drivers/scsi/arm/oak.c      |    3 
>  drivers/scsi/dmx3191d.c     |    1 
>  drivers/scsi/dtc.c          |    2 
>  drivers/scsi/dtc.h          |    1 
>  drivers/scsi/g_NCR5380.c    |    2 
>  drivers/scsi/g_NCR5380.h    |    1 
>  drivers/scsi/mac_scsi.c     |    3 
>  drivers/scsi/pas16.c        |    2 
>  drivers/scsi/pas16.h        |    1 
>  drivers/scsi/t128.c         |    2 
>  drivers/scsi/t128.h         |    1 
>  13 files changed, 152 insertions(+), 40 deletions(-)
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
