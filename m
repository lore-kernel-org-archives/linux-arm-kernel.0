From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 25 Jul 2014 18:37:46 +0200
Subject: [PATCH v11 0/2] Add support for the Allwinner A31 DMA Controller
In-Reply-To: <20140725131217.GS8181@intel.com>
References: <1405626376-471-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140725131217.GS8181@intel.com>
Message-ID: <20140725163746.GC20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Fri, Jul 25, 2014 at 06:42:17PM +0530, Vinod Koul wrote:
> On Thu, Jul 17, 2014 at 09:46:14PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > This patchset adds support for the DMA controller found in the
> > Allwinner A31 and A23 SoCs.
> > 
> > This has been tested using the newly introduced SPI driver on an A31
> > EVK. Support for DMA-driven SPI transfers will be the subject of
> > another patch serie.
> > 
> > This has been around for around 5 monthes now, and didn't get any
> > review but nitpicks for three versions, so I feel like it could be
> > merged quite quickly.
> I have applied this now.

Thanks.

> Can you please send follow patches for these:
> - don't recall if I pointed earlier, but can we use direct conversion for
>   calculating convert_burst() and convert_buswidth(), latter one at least
>   seem doable

Ok. Do you still want the error reporting for the invalid width and
burst size?

> - don't use devm_request_irq(). You have irq enabled and you have killed
>   tasklet. This is too racy. You need to ensure no irqs can be generated before killing
>   tasklets.

Ok, would calling disable_irq before killing the tasklet an option for
you ? that would allow to keep the devm_request_irq.

> - use synchronize_irq() before killing tasklet

Actually, I already do it, like you suggested previously. See
sun6i_kill_tasklet.

I'll also send patches for the various breakages and warnings spotted
by the autobuilders.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140725/ebf2b18a/attachment.sig>
