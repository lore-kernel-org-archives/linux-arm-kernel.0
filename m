From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Oct 2015 13:49:06 +0200
Subject: [PATCH] scsi: advansys needs ISA dma api for ISA support
In-Reply-To: <8749889.aUxSEGWaCq@wuerfel>
References: <5081546.QjQ32dGX2L@wuerfel> <561F96B7.4050300@suse.de>
 <561F977B.1030009@suse.de> <8749889.aUxSEGWaCq@wuerfel>
Message-ID: <5620E432.1000709@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 05:04 PM, Arnd Bergmann wrote:
> On Thursday 15 October 2015 14:09:31 Hannes Reinecke wrote:
>> On 10/15/2015 02:06 PM, Hannes Reinecke wrote:
>>> On 10/12/2015 05:10 PM, Arnd Bergmann wrote:
>>>> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
>>>> index d2f480b04a52..d4aa6a1a806c 100644
>>>> --- a/drivers/scsi/Kconfig
>>>> +++ b/drivers/scsi/Kconfig
>>>> @@ -499,6 +499,7 @@ config SCSI_ADVANSYS
>>>>      tristate "AdvanSys SCSI support"
>>>>      depends on SCSI
>>>>      depends on ISA || EISA || PCI
>>>> +    depends on ISA_DMA_API || !ISA
>>>>      help
>>>>        This is a driver for all SCSI host adapters manufactured by
>>>>        AdvanSys. It is documented in the kernel source in
>>>>
>>> Sorry to chime in again, but wouldn't this allow to build on platforms
>>> which have neither ISA_DMA_API nor ISA, like oldish sparc systems with
>>> proprietary S-BUS?
> 
> No, the first dependency is still in place. It could also be written as
> 
> depends on (ISA && ISA_DMA_API) || EISA || PCI
> 
> which might be easier to understand. Do you want me to resubmit it like that?
> 
Yes, please do so.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
