From: hare@suse.de (Hannes Reinecke)
Date: Thu, 30 Oct 2014 08:31:00 +0100
Subject: [PATCH v2 13/36] ncr5380: Move static PDMA spin counters to host
 data
In-Reply-To: <20141027052610.275439151@telegraphics.com.au>
References: <20141027052607.105914311@telegraphics.com.au>
 <20141027052610.275439151@telegraphics.com.au>
Message-ID: <5451E934.6010902@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/2014 06:26 AM, Finn Thain wrote:
> Static variables from dtc.c and pas16.c should not appear in the core
> NCR5380.c driver. Aside from being a layering issue this worsens the
> divergence between the three core driver variants (atari_NCR5380.c and
> sun3_NCR5380.c don't support PSEUDO_DMA) and it can mean multiple hosts
> share the same counters.
> 
> Fix this by making the pseudo DMA spin counters in the core more generic.
> This also avoids the abuse of the {DTC,PAS16}_PUBLIC_RELEASE macros, so
> they can be removed.
> 
> oak.c doesn't use PDMA and hence it doesn't use the counters and hence it
> needs no write_info() method. Remove it.
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
