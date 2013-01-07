From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 7 Jan 2013 11:56:19 -0600
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <20130107184352.2e90abfb@skate>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130107164845.GA2911@kroah.com> <20130107180708.2ffc1540@skate>
 <20130107172340.GA32401@kroah.com> <20130107184022.72b23aa9@skate>
 <20130107184352.2e90abfb@skate>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206D6C98E38@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 07, 2013 10:44 AM, Thomas Petazzoni wrote:
> On Mon, 7 Jan 2013 18:40:22 +0100, Thomas Petazzoni wrote:
>
>>>> Not having a kernel driver means that gazillions of applications
>>>> re-invent the same piece of code over and over again, have to hardcode
>>>> the GPIO numbers for a given piece of hardware, while the kernel
>>>> abstract all of this very nicely.
>>> 
>>> That sounds like a wonderful use of a userspace library to do this
>>> properly.  Much like libusb does, right?
>>> 
>>> I still think as this can be done in userspace, it probably should be.
>> 
>> Understood. Patches discarded.
>
> Thinking more about this. How would your userspace library know on which
> GPIOs your 7-seg segment device is connected? Should it parse the
> Device Tree from userspace? Given by the user-space application who
> would have to hardcode the GPIO numbers, completely defeating the
> hardware abstraction layer that the kernel intends to be?

Maybe an 'init' of 'config' function in the library should allow the user to
define the GPIOs that are connected to the 7-seg display? Or store the
GPIOs in some config file that the library parses when it's loaded.

This does require the user to know what GPIOs are connected and
forces then to do a bit of setup to use the display. But the actual use of
the display is still abstracted.

The library should also allow for multiple 7-seg displays. The old PC "post"
diagnostic boards usually had two displays on them.

Just my 2 cents....

Regards,
Hartley
