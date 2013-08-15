From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Aug 2013 19:33:19 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815182600.GA22567@kroah.com>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
 <CAKv+Gu9mOxoTsK5g-GX2Khvu0FSUBZRCL0Jw6F6vrMG=fNfy1Q@mail.gmail.com>
 <20130815155652.GB14792@kroah.com>
 <CAKv+Gu8_65EkDkn6-W1NKZSs9P8KOxfFNzFNXq0Eqm5dMYGxwQ@mail.gmail.com>
 <20130815182600.GA22567@kroah.com>
Message-ID: <20130815183319.GE23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 11:26:00AM -0700, Greg KH wrote:
> That's their decision, which is fine.  Getting the Linux CAN stack
> "certified" might be a good goal for a manufacturer who wants to ship
> Linux for this type of system, although we all know how much those
> things really matter when it comes to technical issues :)

If response times matter, and you're relying on software to produce
those response times, then you really need to look at threaded IRQs.
The standard Linux interrupt model sucks, especially if you have USB
enabled.

I'm still seeing upwards of 2.6ms servicing times for USB keyboards
and nice, which given that they are just a set of keys and a position
sensor is totally crazy.

The alternative is we need to throw out the idea that IRQs should be
disabled when servicing hard interrupts and have real interrupt
priorities, where we can nest quicker interrupt handling inside the
slow stuff.
