From: khilman@ti.com (Kevin Hilman)
Date: Thu, 25 Aug 2011 11:16:25 -0700
Subject: How to handle named resources with DT?
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
	<20110825102824.GB10405@n2100.arm.linux.org.uk>
	<201108251705.43168.arnd@arndb.de>
Message-ID: <877h6173wm.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thursday 25 August 2011, Russell King - ARM Linux wrote:
>> 
>> On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
>> > on top of all that, for IPs which are used on many SoCs (such as MUSB)
>> > it's quite silly to force all users to provide resources in a certain
>> > order. It sounds to me that this will be prone to error in many ways
>> > until everything is synced up and on the correct order.
>> > 
>> > Ditching _byname is a very bad idea.
>> 
>> I continue to disagree.  The current _byname is an abonimation and hack
>> to try to "fix" this problem.
>> 
>> _byname should have been implemented differently - rather than overriding
>> the resources name field (which is normally specified to be the device
>> or driver name), a new field should have been introduced in struct resource
>> to carry the resource sub-name (which is really what it is.)
>> 
>> That would have avoided making /proc/iomem completely illegible with
>> multiple devices using this feature.
>
> I agree 100%.

Please clarify. 

What I hear Russell saying is a problem with the *implementation* of the
_byname API.  

What I hear you sating is that since DT doesn't support this, we need to
remove it's usage completely from platform_devices also.

These are two very different approaches.

Fixing the implementation as Russell suggested seems relatively easy,
and conceptually similar to adding it to the DT.  Removing _byname all
together seems like significant work just to avoid adding a feature to
the DT core.

Kevin
