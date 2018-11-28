From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 28 Nov 2018 16:21:05 +0100
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
Message-ID: <3555131.qyOKUBSTPx@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 15. November 2018, 16:45:30 CET schrieb Souptick Joarder:
> Previouly drivers have their own way of mapping range of
> kernel pages/memory into user vma and this was done by
> invoking vm_insert_page() within a loop.
> 
> As this pattern is common across different drivers, it can
> be generalized by creating a new function and use it across
> the drivers.
> 
> vm_insert_range is the new API which will be used to map a
> range of kernel memory/pages to user vma.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <willy@infradead.org>

Except the missing EXPORT_SYMBOL for module builds this new
API is supposed to run also within the Rockchip drm driver, so
on rk3188, rk3288, rk3328 and rk3399 with graphics
Tested-by: Heiko Stuebner <heiko@sntech.de>
