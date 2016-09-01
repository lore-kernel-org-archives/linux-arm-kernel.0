From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 1 Sep 2016 10:24:48 +0300
Subject: [PATCH v3 0/8] drm/tilcdc: Address LCDC rev 2 color errata +
 other fixes
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <43d0d368-f19a-a098-0641-8d4314815d80@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/16 16:14, Jyri Sarha wrote:
> Changes since v2:
> - Fiddle with color wiring propety once more, now it follows this Tomi's
>   comment:
>   - No property set: driver advertises RG16 and RG24. This is
>     wrong, but that's what the current status is, right?
>   - Property set to "default" or "straight" or whatever: driver
>     says RG16 and BG24
>   - Property set to "crossed": driver says BG16 and RG24
> - Add v2 version of "drm/tilcdc: Write DMA base and ceiling address with..."
>   - The first version was sent individually, this second version has
>     __iowmb(); and __cpu_to_le64(); added to tilcdc_write64()
> 
> Changes since v1:
> - Change the blue-and-red-wiring property to boolean blue-and-red-crossed
>   - This breaks to little backward compatibility the earlier series had, but
>     makes the binding more straight forward
>   - This changes requires changes to am335x-evm and am335x-evmsk dts-files
>   - The old beaglebone-black dts files remain compatible, but the patch
>     suggests in commenst on how to support 24-bit RGB mode with BBB
> 
> The first patch ("drm/tilcdc: Remove drm_helper_disable_unused_functions()
> call") is completely independent fix.
> 
> The red and blue components are reversed between 24 and 16 bit modes
> on am335x LCDC output pins. To get 24 RGB format the wires red and
> blue wires has to be crossed and this in turn causes 16 colors output
> to be in BGR format. With straight wiring the 16 color is RGB and 24
> bit is BGR. These patches try to deal with the issue in reasonable
> manner.
> 
> For more details see section 3.1.1 in AM335x Silicon Errata:
> http://www.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=sprz360

Aside the few minor comments I had, for the series:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/fe9e5753/attachment.sig>
