From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 22 May 2011 14:56:45 +0200
Subject: [RFC PATCH 2/2] omap: switch to ioremap function pointer
In-Reply-To: <4DD8F77C.9050206@ti.com>
References: <1306055080-30420-1-git-send-email-plagnioj@jcrosoft.com>
	<201105221335.03688.arnd@arndb.de> <4DD8F77C.9050206@ti.com>
Message-ID: <201105221456.45486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 22 May 2011 13:46:04 Santosh Shilimkar wrote:
> At least on OMAP, the fixed mappings used are mainly the interconnect,
> infrastructure, memory controller and most of these are not associated
> with any driver.
> 
> On OMAP, the fixed mappings are handled directly so nothing fishy there.
> 
> Attributes are already provided via io descriptor for fixed mapping
> and that should remain fixed. O.w there is no meaning for the fixed
> mapping.
> 
> For dynamic mapping, different attributes work as usual via
> __ioremap().
> 
> So I don't see why you will have conflicting mapping at all?

Ok, great!

If that's the case, then you don't need omap_ioremap at all
and you can simply remove it. I assume that when we make the
other platforms do the same as omap, we also won't need a
per-platform ioremap function pointer.

	Arnd
