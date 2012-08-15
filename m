From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Wed, 15 Aug 2012 22:06:55 +0200
Subject: [PATCH v3 08/10] of/address: Handle #address-cells > 2 specially
In-Reply-To: <50183DA3.8020308@gmail.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de>
 <1343332512-28762-9-git-send-email-thierry.reding@avionic-design.de>
 <50183DA3.8020308@gmail.com>
Message-ID: <20120815200655.GC12870@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2012 at 03:18:43PM -0500, Rob Herring wrote:
> On 07/26/2012 02:55 PM, Thierry Reding wrote:
> > When a bus specifies #address-cells > 2, of_bus_default_map() now
> > assumes that the mapping isn't for a physical address but rather an
> > identifier that needs to match exactly.
> > 
> > This is required by bindings that use multiple cells to translate a
> > resource to the parent bus (device index, type, ...).
> > 
> > See here for the discussion:
> > 
> > 	https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-June/016577.html
> > 
> > Originally-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Hi Rob,

Were you going to take this through your DT tree? I'm trying to reduce
the number of patches in this series to make it more manageable and
split it into smaller chunks. There are also a couple of issues that
need to be resolved so I don't know if I can get the whole series into
shape for 3.7.

However if you don't think this patch is useful to be applied by itself
I can also carry it until the complete series is ready.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120815/88eafd00/attachment.sig>
