From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 Dec 2015 08:55:21 +0100
Subject: [PATCH v3 57/77] ncr5380: Use standard list data structure
In-Reply-To: <20151222011753.525503258@telegraphics.com.au>
References: <20151222011737.980475848@telegraphics.com.au>
 <20151222011753.525503258@telegraphics.com.au>
Message-ID: <567901E9.70006@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/22/2015 02:18 AM, Finn Thain wrote:
> The NCR5380 drivers have a home-spun linked list implementation for
> scsi_cmnd structs that uses cmd->host_scribble as a 'next' pointer. Adopt
> the standard list_head data structure and list operations instead. Remove
> the eh_abort_handler rather than convert it. Doing the conversion would
> only be churn because the existing EH handlers don't work and get replaced
> in a subsequent patch.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>
> ---
>
> Changed since v2:
> - Fix NULL pointer dereference in NCR5380_reselect() when SUPPORT_TAGS is
>    enabled in the atari_NCR5380.c core driver.
>
Well, using ->host_scribble allows for an easy check on the midlayer if 
a command has been properly released by the LLDD. But that's just a 
side-note.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
