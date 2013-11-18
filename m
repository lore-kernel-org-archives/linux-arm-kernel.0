From: jonathan@jonmasters.org (Jon Masters)
Date: Mon, 18 Nov 2013 12:33:19 -0500
Subject: ACPI vs DT at runtime
In-Reply-To: <201311180945.52764.arnd@arndb.de>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <3371903.8j54vrCjEN@wuerfel>
 <CAOesGMiYyOcvr3Aqs-p8zc=XDwJM9NZtNxtxrTZssc6F=siZCw@mail.gmail.com>
 <201311180945.52764.arnd@arndb.de>
Message-ID: <528A4F5F.7080104@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2013 03:45 AM, Arnd Bergmann wrote:
> On Sunday 17 November 2013, Olof Johansson wrote:

>> Yep, and together for review is a critical part. I'm not saying that
>> the ideal solution is a flashed DTB, but it's better than ACPI. A
>> flashed DTB that's _easy to update_ as part of an OS install would
>> probably be one of the best solutions we could ask for though.
> 
> Right: the assumption on the DT boot interfaces is that board designers
> make mistakes and are working on moving targets, so we need ways to update
> the DTB. By contrast, the assumption on ACPI is that server firmware
> authors know what they are doing and you shouldn't let anyone else mess
> with the ACPI bits because doing so might damage your hardware. We're
> in trouble if the second assumption turns out wrong.

In the server space we *never* ship updated ACPI tables in Red Hat
products, and we never would ship updated tables as part of the OS.
Platform data is platform data. It belongs to the vendor shipping the
system, never to the OS. Yes, there are workarounds for bugs but on the
whole you do in fact count on server vendors not to screw it up, and if
they do then it is up to them to ship a BIOS update for their hardware.

In the Fedora space, even on 32-bit, we tried to not get in the business
of shipping DeviceTree blobs (way back when) that should be shipped by
the platform, but alas many systems don't have flash to store the DTB.
Coupled with the moving target we're dealing with there...things have
been ugly. In the v8 server space, there will be no shipping of platform
data. It will be ACPI tables passed in via UEFI, never updated by the
OS, and owned wholly by the platform vendor.

Jon.
