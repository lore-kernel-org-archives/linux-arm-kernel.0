From: hare@suse.de (Hannes Reinecke)
Date: Mon, 09 Nov 2015 08:09:39 +0100
Subject: [PATCH V2 1/3] scsi: mptxsas: try 64 bit DMA when 32 bit DMA fails
In-Reply-To: <1447034266-28003-2-git-send-email-okaya@codeaurora.org>
References: <1447034266-28003-1-git-send-email-okaya@codeaurora.org>
 <1447034266-28003-2-git-send-email-okaya@codeaurora.org>
Message-ID: <564046B3.8090505@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/09/2015 02:57 AM, Sinan Kaya wrote:
> Current code gives up when 32 bit DMA is not supported.
> This problem has been observed on systems without any
> memory below 4 gig.
> 
> This patch tests 64 bit support before bailing out to find
> a working combination.
> 
That feels decidedly odd.

Why do you probe for 64bit if 32bit fails?
Typically it's the other way round, on the grounds that 64bit DMA
should be preferred over 32bit.
Can you explain why it needs to be done the other way round here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
