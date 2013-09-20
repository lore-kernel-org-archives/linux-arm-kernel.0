From: bhutchings@solarflare.com (Ben Hutchings)
Date: Fri, 20 Sep 2013 02:21:37 +0100
Subject: [PATCH 01/51] DMA-API: provide a helper to set both DMA and
 coherent DMA masks
In-Reply-To: <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMlja-0007fA-HU@rmk-PC.arm.linux.org.uk>
Message-ID: <1379640097.2500.4.camel@bwh-desktop.uk.level5networks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-09-19 at 22:25 +0100, Russell King wrote:
> Provide a helper to set both the DMA and coherent DMA masks to the
> same value - this avoids duplicated code in a number of drivers,
> sometimes with buggy error handling, and also allows us identify
> which drivers do things differently.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  Documentation/DMA-API-HOWTO.txt |   37 ++++++++++++++++++++++---------------
>  Documentation/DMA-API.txt       |    8 ++++++++
>  include/linux/dma-mapping.h     |   14 ++++++++++++++
>  3 files changed, 44 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/DMA-API-HOWTO.txt b/Documentation/DMA-API-HOWTO.txt
> index 14129f1..5e98303 100644
> --- a/Documentation/DMA-API-HOWTO.txt
> +++ b/Documentation/DMA-API-HOWTO.txt
[...]
> -dma_set_coherent_mask() will always be able to set the same or a
> -smaller mask as dma_set_mask(). However for the rare case that a
> +The coherent coherent mask will always be able to set the same or a
> +smaller mask as the streaming mask. However for the rare case that a
[...]

The new wording doesn't make sense; a mask doesn't set itself.  I would
suggest:

"The coherent mask can always be set to the same or a smaller mask than
the streaming mask."

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
