From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 18 Apr 2012 11:27:58 -0600
Subject: [PATCH 1/1] dt: Add general DMA window parser
In-Reply-To: <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
References: <201204180731.54064.arnd@arndb.de><20120418.121824.1894043789811063795.hdoyu@nvidia.com><20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
 <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
Message-ID: <4F8EF99E.3050709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2012 04:19 AM, Hiroshi Doyu wrote:

> Subject: [PATCH 1/1] dt: Add general DMA window parser
> 
> This code was stolen from:
> 	"arch/microblaze/kernel/prom_parse.c"
> 	"arch/powerpc/kernel/prom_parse.c"
> 
> Once "ibm," prefix is removed from dts file. This generic one could
> replace the originals.

> +extern void of_parse_dma_window(struct device_node *dn,
> +		       const void *dma_window_prop, unsigned long *busno,
> +			       unsigned long *phys, unsigned long *size);

At least some other of_*() parsing functions take the property name
rather than the property pointer, and also take an index into the
property in order to support multiple entries in it. See for example
of_parse_phandle and of_get_named_gpio_flags. Should this new API be
similar? E.g.:

extern void of_parse_dma_window(struct device_node *np,
			const char *propname, int index,
			unsigned long *busno,
			unsigned long *phys, unsigned long *size);
