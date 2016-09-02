From: pku.leo@gmail.com (Leo Li)
Date: Fri, 2 Sep 2016 17:16:31 -0500
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <6414695.LEIYfGPUEg@wuerfel>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87vb31kdvh.fsf@intel.com>
 <CADRPPNTQURmuwyuXCjHZcCq6jmQDFiyEUqfcqO-us15nosGCDA@mail.gmail.com>
 <6414695.LEIYfGPUEg@wuerfel>
Message-ID: <CADRPPNR1_6fbaHLvbmNZW+r7YWW=vOZ+wGCS-MAcNPi9gB3eOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 2, 2016 at 5:43 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday, September 1, 2016 5:14:28 PM CEST Leo Li wrote:
>>
>> Hi Felipe and Arnd,
>>
>> It has been a while since the last response to this discussion, but we
>> haven't reached an agreement yet!  Can we get to a conclusion on if it
>> is valid to create child platform device for abstraction purpose?  If
>> yes, can this child device do DMA by itself?
>
> I'd say it's no problem for a driver to create child devices in order
> to represent different aspects of a device, but you should not rely on
> those devices working when used with the dma-mapping interfaces.
>
> This used to be simpler back when we could configure the kernel for
> only one SoC platform at a time, and the platforms could provide their
> own overrides for the dma-mapping interfaces. These days, we rely on
> firmware or bootloader to describe various aspects of how DMA is done,
> so you can't assume that passing a device without an of_node pointer
> or ACPI data into those functions will do the right thing.

Can we use the firmware or bootloader information to provide the
default dma-mapping attributes for devices that doesn't have an
of_node pointer or ACPI data?  This will at least restore what we had
previously provided .  I'm concerned that changing all the drivers
that are creating child device will be a big effort.  Like I mentioned
in another thread, there are many instances of platform_device_add()
under the drivers/ directory.

- Leo
