From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 29 Feb 2016 15:17:49 -0800
Subject: [PATCH v2 4/4] drivers: dma-coherent: use memset_io for
 DMA_MEMORY_IO mappings
In-Reply-To: <7942c970d1071643f3763de6eaf6d55a3945a069.1456225103.git.brian.starkey@arm.com>
References: <cover.1456225103.git.brian.starkey@arm.com>
 <7942c970d1071643f3763de6eaf6d55a3945a069.1456225103.git.brian.starkey@arm.com>
Message-ID: <20160229151749.a972ae993adffb667140548d@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Feb 2016 16:09:24 +0000 Brian Starkey <brian.starkey@arm.com> wrote:

> Use memset_io() for DMA_MEMORY_IO mappings which are mapped as I/O
> memory, and regular memset() for DMA_MEMORY_MAP mappings.
> 
> This fixes the below alignment fault on arm64 for DMA_MEMORY_IO
> mappings, where memset() uses the DC ZVA instruction which is
> invalid on device memory.

What's the urgency of this fix?  "Hair on fire needed in stable asap"
or "Nice to have in there for 4.6" or what?
