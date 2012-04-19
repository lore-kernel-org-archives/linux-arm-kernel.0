From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 19 Apr 2012 15:19:20 +0300
Subject: [PATCH 1/1] dt: Add general DMA window parser
In-Reply-To: <4F8EF99E.3050709@wwwdotorg.org>
References: <201204180731.54064.arnd@arndb.de>
 <20120418.121824.1894043789811063795.hdoyu@nvidia.com>
 <20120418092613.GA8632@avionic-0098.mockup.avionic-design.de>
 <20120418.131907.2172387798112620167.hdoyu@nvidia.com>
 <4F8EF99E.3050709@wwwdotorg.org>
Message-ID: <20120419151920.68ab735a5b9eb8fb938b4d11@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2012 19:27:58 +0200
Stephen Warren <swarren@wwwdotorg.org> wrote:

> On 04/18/2012 04:19 AM, Hiroshi Doyu wrote:
> 
> > Subject: [PATCH 1/1] dt: Add general DMA window parser
> > 
> > This code was stolen from:
> > 	"arch/microblaze/kernel/prom_parse.c"
> > 	"arch/powerpc/kernel/prom_parse.c"
> > 
> > Once "ibm," prefix is removed from dts file. This generic one could
> > replace the originals.

It seems that the "ibm," prefix is not used in .dts files, but it
comes from the PAPR compliant firmware and cannot be changed.

The easiest solution would be to make the function understand both
variants.

> > +extern void of_parse_dma_window(struct device_node *dn,
> > +		       const void *dma_window_prop, unsigned long *busno,
> > +			       unsigned long *phys, unsigned long *size);
> 
> At least some other of_*() parsing functions take the property name
> rather than the property pointer, and also take an index into the
> property in order to support multiple entries in it. See for example
> of_parse_phandle and of_get_named_gpio_flags. Should this new API be
> similar? E.g.:
> 
> extern void of_parse_dma_window(struct device_node *np,
> 			const char *propname, int index,
> 			unsigned long *busno,
> 			unsigned long *phys, unsigned long *size);

At least, I can add the code checking the return value of this
function, which won't change the existing code.

Does anyone know the format of "ibm,dma-window"?
