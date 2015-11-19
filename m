From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Nov 2015 08:41:11 +0100
Subject: [PATCH 05/71] ncr5380: Remove NCR5380_local_declare and
 NCR5380_setup macros
In-Reply-To: <20151118083456.611699008@telegraphics.com.au>
References: <20151118083455.331768508@telegraphics.com.au>
 <20151118083456.611699008@telegraphics.com.au>
Message-ID: <564D7D17.8060900@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 09:35 AM, Finn Thain wrote:
> The NCR5380_local_declare and NCR5380_setup macros exist to define and
> initialize a particular local variable, to provide the address of the
> chip registers needed for the driver's implementation of its
> NCR5380_read/write register access macros.
>
> In cumana_1 and macscsi, these macros generate pointless code like this,
> 	struct Scsi_Host *_instance;
> 	_instance = instance;
>
> In pas16, the use of NCR5380_read/write in pas16_hw_detect() requires that
> the io_port local variable has been defined and initialized, but the
> NCR5380_local_declare and NCR5380_setup macros can't be used for that
> purpose because the Scsi_Host struct has not yet been instantiated.
>
> Moreover, these macros were removed from atari_NCR5380.c long ago and
> now they constitute yet another discrepancy between the two core driver
> forks.
>
> Remove these "optimizations".
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
