From: robherring2@gmail.com (Rob Herring)
Date: Tue, 23 Oct 2012 15:06:46 -0500
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210231522230.1635-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210231522230.1635-100000@iolanthe.rowland.org>
Message-ID: <5086F8D6.5050605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/23/2012 02:33 PM, Alan Stern wrote:
> On Tue, 23 Oct 2012, Stephen Warren wrote:
> 
>>> Nothing intrinsically distinguishes this class of hardware.  The only
>>> thing these devices have in common is that they can be managed by
>>> Linux's ehci-platform driver.
>>
>> I don't agree. They're all EHCI USB controllers (or all EHCI USB
>> controllers that don't require custom drivers due to quirks), which is a
>> much more general statement than anything related to which driver Linux
>> uses for them.
> 
> That's true, but it doesn't distinguish these devices.  There are other
> EHCI controllers with no quirks that nevertheless can't be handled by
> ehci-platform because they have requirements (_not_ quirks) that
> ehci-platform is unable to deal with currently -- clocks or power
> supplies or special register settings or PHYs or etc.

But what if the h/w has quirks you haven't yet discovered? You need the
compatible property to be specific now, so if there are any future
driver changes needed the DT does not have to change (as it may be in
firmware which you can't change).

>>> In essense, we're trying to say that the HW is compatible with a 
>>> particular driver rather than with some other type of HW.
>>
>> Using a compatible value in order to pick a specific driver in Linux is
>> explicitly against the device tree design principles; DT is supposed to
>> represent just the hardware.
>>
>>> Maybe DT
>>> wasn't intended to provide this kind of information, but it seems like 
>>> a logical thing to do.  Unless DT already offers some other way to 
>>> accomplish the same thing?
>>
>> The typical way is for the Linux driver to declare that is supports a
>> variety of different HW models.
>>
>> Admittedly this is annoying when there are many HW models that otherwise
>> wouldn't need any driver changes, hence the desire to (additionally)
>> include some generic value in the compatible field, but again, what that
>> generic value is should be driven by the HW itself, not the SW that's
>> using it.
> 
> Okay, fine.  But then what should the binding documentation specify for
> the compatible value?  A list of all the HW models that the driver
> currently supports?

The binding docs should be independent of the driver. There may be
fields the driver ignores. So you need to document all defined
compatible strings. It is fine if the driver only has "usb-ehci", but it
is not fine for the DT to only have that.

Rob
