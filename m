From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 May 2013 15:42:41 +0100
Subject: [RFC PATCH] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <1369223711-2995-1-git-send-email-ming.lei@canonical.com>
References: <1369223711-2995-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20130522144240.GA4173@localhost.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 12:55:11PM +0100, Ming Lei wrote:
> Currently flush_dcache_page() thinks pages as non-mapped if
> mapping_mapped(mapping) return false. This approach is very
> coase:
> 	- mmap on part of file may cause all pages backed on
> 	the file being thought as mmaped
> 
> 	- file-backed pages aren't mapped into user space actually
> 	if the memory mmaped on the file isn't accessed

That's the meaning of mapping_mapped(), it doesn't tell whether the page
has a user virtual address.

> This patch also uses page_mapcount() to decide if the page has been
> mapped.

Better use page_mapped() instead.

-- 
Catalin
