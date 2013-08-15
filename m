From: greg@kroah.com (Greg KH)
Date: Thu, 15 Aug 2013 11:44:26 -0700
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130815183319.GE23006@n2100.arm.linux.org.uk>
References: <CAGsJ_4xnivwNW_Pvhv7Jg62a94d5FChwqEwnNX3Miqd5fAxNHA@mail.gmail.com>
 <20130815042812.GA8968@kroah.com>
 <CABb+yY1YKGkAeb-8GbadUoV5g54iCdrYGnD_VSpaNmtfXXhpyA@mail.gmail.com>
 <CAGsJ_4yZ7Rf7UV-1u3cG_V9mrtCWD=LYBeuKQaz0SWLYoHhwwg@mail.gmail.com>
 <20130815080532.GB7080@kroah.com>
 <CAKv+Gu9mOxoTsK5g-GX2Khvu0FSUBZRCL0Jw6F6vrMG=fNfy1Q@mail.gmail.com>
 <20130815155652.GB14792@kroah.com>
 <CAKv+Gu8_65EkDkn6-W1NKZSs9P8KOxfFNzFNXq0Eqm5dMYGxwQ@mail.gmail.com>
 <20130815182600.GA22567@kroah.com>
 <20130815183319.GE23006@n2100.arm.linux.org.uk>
Message-ID: <20130815184426.GA23581@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 07:33:19PM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 15, 2013 at 11:26:00AM -0700, Greg KH wrote:
> > That's their decision, which is fine.  Getting the Linux CAN stack
> > "certified" might be a good goal for a manufacturer who wants to ship
> > Linux for this type of system, although we all know how much those
> > things really matter when it comes to technical issues :)
> 
> If response times matter, and you're relying on software to produce
> those response times, then you really need to look at threaded IRQs.
> The standard Linux interrupt model sucks, especially if you have USB
> enabled.

Using USB withing a "trusted OS" situation isn't very wise for a number
of reasons :)

There is work happening on making USB host controllers use threaded
interrups, the first round of changes just went into the usb-next branch
in linux-next, and will show up in 3.12.  It reduces the overhead of USB
on ARM systems by a measurable ammount.  There are more patches coming
for this as well to fix up other related issues, and USB host
controllers.

> I'm still seeing upwards of 2.6ms servicing times for USB keyboards
> and nice, which given that they are just a set of keys and a position
> sensor is totally crazy.

USB is not exactly a low-latency protocol.  A lot happens for just those
"key press" packets to make it to the machine.

thanks,

greg k-h
