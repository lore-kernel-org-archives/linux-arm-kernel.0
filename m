From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 21 Nov 2013 16:56:03 +0000
Subject: ACPI
In-Reply-To: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
Message-ID: <20131121165603.GA22960@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 01:42:32PM -0500, Jon Masters wrote:

> Starting a new thread with a question. Suppose for a moment that ACPI 
> is the way of the future and that there is, in fact, already a three 
> year story behind this[0] that will come out in due course. What could 
> be done to make things smoother /going forward/? Could we articulate a 
> series of useful asks that would help with moving forward with ACPI? 
> For example, it is clear that there needs to be more involvement in 
> the standardization of ACPI (this is why we initiated the governance 
> model change of ACPI several years ago that has taken this long to 
> resolve with everyone involved in that) and we want to get more ARM 
> kernel folks involved. But what else? Blank slate. What do we need to 
> make ACPI a success here?

Define what ARM vendors actually want from ACPI. Most ACPI functionality 
is entirely invisible to userspace. The enterprise-level functionality 
in the DSDT is all vendor-specific and exists primarily because of a 
Windows design decision[0], so there's no obvious requirement to do 
things the same way this time around. The other tables are meaningful, 
but also don't require the DSDT or a runtime ACPI interpreter.

The obvious compromise implementation would be to continue using DT for 
device discovery and just use ACPI as a means for providing static data. 
This would be a strict violation of the ACPI spec as it currently 
stands, but the only real change would be making the DSDT optional. Why 
would that not satisfy vendor requirements?

[0] Microsoft specced a mechanism for gluing WMI into ACPI, which means 
you can pretty much implement all your vendor magic in userspace rather 
than having to write a driver and get it signed

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
