From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Aug 2013 07:20:57 -0500
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1376924669-28873-4-git-send-email-m.szyprowski@samsung.com>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <1376924669-28873-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAL_JsqJ3hcpgj6GgzqZdgLLqGQXmzys5PvCgy+36RpvQELvMjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 10:04 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> This patch adds device tree support for contiguous and reserved memory
> regions defined in device tree.
>
> Large memory blocks can be reliably reserved only during early boot.
> This must happen before the whole memory management subsystem is
> initialized, because we need to ensure that the given contiguous blocks
> are not yet allocated by kernel. Also it must happen before kernel
> mappings for the whole low memory are created, to ensure that there will
> be no mappings (for reserved blocks) or mapping with special properties
> can be created (for CMA blocks). This all happens before device tree
> structures are unflattened, so we need to get reserved memory layout
> directly from fdt.
>
> Later, those reserved memory regions are assigned to devices on each
> device structure initialization.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> Acked-by: Michal Nazarewicz <mina86@mina86.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>

Reviewed-by: Rob Herring <rob.herring@calxeda.com>
