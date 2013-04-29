From: marc.ceeeee@gmail.com (Marc C)
Date: Mon, 29 Apr 2013 14:21:49 -0700
Subject: [RFC/PATCH v2 2/2] drivers: dma-contiguous: add initialization
 from device tree
In-Reply-To: <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
References: <1365679330-2514-1-git-send-email-m.szyprowski@samsung.com>
 <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAO1A-8DiZoMVGcjOqK6VYP5Qito55i=gsKApQM=LGbQVx3iCwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  /**
>   * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
>   * @limit: End address of the reserved memory (optional, 0 for any).
> @@ -149,6 +200,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>
>         pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>
> +#ifdef CONFIG_OF
> +       of_scan_flat_dt(cma_fdt_scan, NULL);
> +#endif
> +

What is your expectation with the contention between default region
setup via the kernel config (CONFIG_CMA_SIZE_SEL_*) and via the DT?
Could the call to 'of_scan_flat_dt()' be done before the setup of the
kernel config early regions, followed by a return code check
'fail-over' scheme, or were you intending for the default region
setups to be mutually-exclusive?

Thanks,
Marc
