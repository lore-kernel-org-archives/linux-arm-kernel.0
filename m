From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 8 Sep 2017 00:53:47 -0700
Subject: [PATCH v6 05/11] arm64/mm: Add support for XPFO
In-Reply-To: <20170907173609.22696-6-tycho@docker.com>
References: <20170907173609.22696-1-tycho@docker.com>
 <20170907173609.22696-6-tycho@docker.com>
Message-ID: <20170908075347.GC4957@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +/*
> + * Lookup the page table entry for a virtual address and return a pointer to
> + * the entry. Based on x86 tree.
> + */
> +static pte_t *lookup_address(unsigned long addr)

Seems like this should be moved to common arm64 mm code and used by
kernel_page_present.
