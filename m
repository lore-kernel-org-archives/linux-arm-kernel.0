From: hare@suse.de (Hannes Reinecke)
Date: Mon, 14 Mar 2016 08:26:45 +0100
Subject: [PATCH 05/22] ncr5380: Disable the DMA errata workaround flag by
 default
In-Reply-To: <20160314042701.956017683@telegraphics.com.au>
References: <20160314042700.596192247@telegraphics.com.au>
 <20160314042701.956017683@telegraphics.com.au>
Message-ID: <56E667B5.3090708@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/14/2016 05:27 AM, Finn Thain wrote:
> The only chip that needs the workarounds enabled is an early NMOS
> device. That means that the common case is to disable them.
> 
> Unfortunately the sense of the flag is such that it has to be set
> for the common case.
> 
> Rename the flag so that zero can be used to mean "no errata workarounds
> needed". This simplifies the code.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
>  drivers/scsi/NCR5380.c      |   14 +++++++-------
>  drivers/scsi/NCR5380.h      |    2 +-
>  drivers/scsi/arm/cumana_1.c |    2 +-
>  drivers/scsi/arm/oak.c      |    2 +-
>  drivers/scsi/dtc.c          |    2 +-
>  drivers/scsi/g_NCR5380.c    |    8 +-------
>  drivers/scsi/pas16.c        |    2 +-
>  drivers/scsi/t128.c         |    2 +-
>  8 files changed, 14 insertions(+), 20 deletions(-)
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
