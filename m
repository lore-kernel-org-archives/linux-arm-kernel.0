From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Nov 2015 14:41:36 -0600
Subject: [PATCH] usb: musb: USB_TI_CPPI41_DMA requires dmaengine support
In-Reply-To: <3958456.qUtBLJFy2S@wuerfel>
References: <4370741.70D0kgBgnp@wuerfel>
 <CADYTM3baomio7+nFizOKFXMav7guow+=GsVaGExBWxQyn9t=2w@mail.gmail.com>
 <3958456.qUtBLJFy2S@wuerfel>
Message-ID: <87twojghvj.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Arnd Bergmann <arnd@arndb.de> writes:
> On Wednesday 18 November 2015 12:29:27 Bin Liu wrote:
>> > diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
>> > index 1f2037bbeb0d..45c83baf675d 100644
>> > --- a/drivers/usb/musb/Kconfig
>> > +++ b/drivers/usb/musb/Kconfig
>> > @@ -159,7 +159,7 @@ config USB_TI_CPPI_DMA
>> >
>> >  config USB_TI_CPPI41_DMA
>> >         bool 'TI CPPI 4.1 (AM335x)'
>> > -       depends on ARCH_OMAP
>> > +       depends on ARCH_OMAP && DMADEVICES
>> >         select TI_CPPI41
>> 
>> I am not sure what the generic policy is, but instead of hiding
>> USB_TI_CPPI41_DMA if DMADEVICES is disabled, I'd like to enable
>> DMADEVICES if USB_TI_CPPI41_DMA is enabled, from user experience
>> perspective.
>
> General policy is that you should not 'select' a symbol that is
> also user-visible, as that tends to cause dependency loops and
> other problems when something is enabled without the user being
> aware of that.
>
> Ideally we should remove the 'select TI_CPPI41' here as well, but
> what we could do instead is to make that a silent symbol and remove
> the prompt so it always gets enabled implicitly when USB_TI_CPPI41_DMA
> and DMADEVICES are both enabled.

that should be perfect now that Tony L fixed this up so we can enable
all MUSB DMA Engines in a single zImage.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151118/b6237d3d/attachment-0001.sig>
