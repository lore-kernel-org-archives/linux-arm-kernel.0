From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 02 Feb 2013 04:07:59 +0400
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <20130201213003.GW2637@n2100.arm.linux.org.uk>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com>
 <5022f635a527470dbd0be932063e9cd2@DFLE72.ent.ti.com>
 <20130201184915.GP2244@beef> <510C1D0E.6030401@mvista.com>
 <20130201185820.GE29898@arwen.pp.htv.fi> <510C2A47.1090607@mvista.com>
 <20130201205600.GA31762@arwen.pp.htv.fi>
 <20130201213003.GW2637@n2100.arm.linux.org.uk>
Message-ID: <510C58DF.3010103@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-02-2013 1:30, Russell King - ARM Linux wrote:

>> On Fri, Feb 01, 2013 at 11:49:11PM +0300, Sergei Shtylyov wrote:
>>>> good point, do you wanna send some patches ?

>>>     I have already sent them countless times and even stuck CPPI 4.1 support (in
>>> arch/arm/common/cppi41.c) in Russell's patch system. TI requested to remove the
>>> patch. :-(

>> sticking into arch/arm/common/ wasn't a nice move. But then again, so
>> wasn't asking for the patch to be removed :-s

> Err, patches don't get removed, they get moved to 'discarded'.

    Any chance to bring it back to life? :-)
    Although... drivers/usb/musb/cppi41.c would need to be somewhat reworked 
for at least AM35x and I don't have time. But that may change, of course.

>>>> I guess to make the MUSB side simpler we would need musb-dma-engine glue
>>>> to map dmaengine to the private MUSB API. Then we would have some
>>>> starting point to also move inventra (and anybody else) to dmaengine
>>>> API.

>>>     Why? Inventra is a dedicated device's private DMA controller, why make
>>> universal DMA driver for it?

>> because it doesn't make sense to support multiple DMA APIs. We can check
>> from MUSB's registers if it was configured with Inventra DMA support and
>> based on that we can register MUSB's own DMA Engine to dmaengine API.

> Hang on.  This is one of the DMA implementations which is closely
> coupled with the USB and only the USB?  If it is...

> I thought this had been discussed _extensively_ before.  I thought the
> resolution on it was:
> 1. It would not use the DMA engine API.
> 2. It would not live in arch/arm.
> 3. It would be placed nearby the USB driver it's associated with.

> (1) because we don't use APIs just for the hell of it - think.  Do we
> use the DMA engine API for PCI bus mastering ethernet controllers?  No.
> Do we use it for PCI bus mastering SCSI controllers?  No.  Because the
> DMA is integral to the rest of the device.

> The DMA engine API only makes sense if the DMA engine is a shared
> system resource.

    Thanks for such extensive wording in the support of my point. :-)

WBR, Sergei
