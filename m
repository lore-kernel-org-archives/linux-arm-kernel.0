From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Apr 2012 11:43:27 +0000
Subject: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to
 prepare for generic dma_ops
In-Reply-To: <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
 <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <201204101143.27915.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch removes the need for offset parameter in dma bounce
> functions. This is required to let dma-mapping framework on ARM
> architecture use common, generic dma-mapping helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

This one worries me a little. I always thought that the range sync 
functions were specifically needed for the dmabounce code. At the
very least, I would expect the changeset comment to have an explanation
of why this was initially done this way and why it's now safe to do
do it otherwise.

	Arnd
