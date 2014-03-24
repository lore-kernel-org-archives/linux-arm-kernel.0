From: simon.kagstrom@netinsight.net (Simon =?UTF-8?B?S8OlZ3N0csO2bQ==?=)
Date: Mon, 24 Mar 2014 14:51:02 +0100
Subject: [PATCH 3/3] ARM: Fix DMA-bounce code to allow sync from_device
 and to_device with bidirectional mappings.
In-Reply-To: <m338i9iwa6.fsf@intrepid.localdomain>
References: <m3siq9iyt2.fsf@intrepid.localdomain>
 <m338i9iwa6.fsf@intrepid.localdomain>
Message-ID: <20140324145102.6cbebfce@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Mar 2014 01:38:41 +0100
Krzysztof Halasa <khc@pm.waw.pl> wrote:

> This is equivalent of a more generic change to lib/dma-debug.c which is
> present since v2.6.33:
> 
> commit 42d53b4ff7d61487d18274ebdf1f70c1aef6f122
> dma-debug: allow DMA_BIDIRECTIONAL mappings to be synced with DMA_FROM_DEVICE
> and DMA_TO_DEVICE.
> 
> There is no need to perform full BIDIR sync (copying the buffers in case
> of swiotlb and similar schemes) if we know that the owner (CPU or device)
> hasn't altered the data.
> 
> Addresses the false-positive reported at
> http://bugzilla.kernel.org/show_bug.cgi?id=14169
> 
> Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

Tested-by: Simon Kagstrom <simon.kagstrom@netinsight.net>

(Tested with a e100 device which previously triggered this).

// Simon
