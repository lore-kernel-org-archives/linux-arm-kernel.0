From: balbi@kernel.org (Felipe Balbi)
Date: Fri, 02 Sep 2016 15:56:53 +0300
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <956cf653-973a-3bfd-9aaa-bdc922995ea6@arm.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
 <6414695.LEIYfGPUEg@wuerfel> <87eg528te7.fsf@linux.intel.com>
 <956cf653-973a-3bfd-9aaa-bdc922995ea6@arm.com>
Message-ID: <87wpiu794a.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Robin Murphy <robin.murphy@arm.com> writes:
>>>> It has been a while since the last response to this discussion, but we
>>>> haven't reached an agreement yet!  Can we get to a conclusion on if it
>>>> is valid to create child platform device for abstraction purpose?  If
>>>> yes, can this child device do DMA by itself?
>>>
>>> I'd say it's no problem for a driver to create child devices in order
>>> to represent different aspects of a device, but you should not rely on
>>> those devices working when used with the dma-mapping interfaces.
>> 
>> heh, that looks like an excuse to me :-)
>> 
>> This will always be a problem for e.g. MFD, for example. Are you saying
>> MFD child-devices shouldn't be allowed to do DMA? It becomes silly when
>> you read it that way, right?
>> 
>>> This used to be simpler back when we could configure the kernel for
>>> only one SoC platform at a time, and the platforms could provide their
>>> own overrides for the dma-mapping interfaces. These days, we rely on
>> 
>> right, so we have a very old regression that just took a complex driver
>> such as dwc3 to trigger ;-)
>> 
>>> firmware or bootloader to describe various aspects of how DMA is done,
>> 
>> there's no DMA description in DT. Every OF device gets the same 32-bit
>> DMA mask and that is, itself, wrong for several devices.
>
> Huh? There's only no DMA description in DT if the device can be assumed
> to be happy with the defaults. Anything else should be using
> "dma-ranges", "dma-coherent", etc. to describe non-default integration

heh, guilty as charged. I never noticed we had dma-ranges or
dma-coherent.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/777330c0/attachment.sig>
