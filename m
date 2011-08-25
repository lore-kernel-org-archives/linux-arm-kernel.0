From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 25 Aug 2011 19:38:18 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <20110825102824.GB10405@n2100.arm.linux.org.uk>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<20110812030218.GP30552@yookeroo.fritz.box>
	<20110812084106.GC19467@legolas.emea.dhcp.ti.com>
	<201108121635.42953.arnd@arndb.de> <4E45422D.4050708@ti.com>
	<CACxGe6s-2EAuvSqzn6yzDvCyVXa8vVVqG2X=1XFrUBnB=jsdxQ@mail.gmail.com>
	<87r54a1v0o.fsf@ti.com>
	<20110824231613.GC19890@legolas.emea.dhcp.ti.com>
	<20110825102824.GB10405@n2100.arm.linux.org.uk>
Message-ID: <4E56888A.5020300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/25/2011 12:28 PM, Russell King - ARM Linux wrote:
> On Thu, Aug 25, 2011 at 02:16:14AM +0300, Felipe Balbi wrote:
>> on top of all that, for IPs which are used on many SoCs (such as MUSB)
>> it's quite silly to force all users to provide resources in a certain
>> order. It sounds to me that this will be prone to error in many ways
>> until everything is synced up and on the correct order.
>>
>> Ditching _byname is a very bad idea.
>
> I continue to disagree.  The current _byname is an abonimation and hack
> to try to "fix" this problem.

What problem are you considering here?

> _byname should have been implemented differently - rather than overriding
> the resources name field (which is _normally_ specified to be the device
> or driver name), a new field should have been introduced in struct resource
> to carry the resource sub-name (which is really what it is.)

I guess we agree on that, but that just means that the implementation is 
bad, not that the function is useless or evil.

> That would have avoided making /proc/iomem completely illegible with
> multiple devices using this feature.

resources are used as well for irq and dma, so that aspect is irrelevant 
in that case.

Assuming that a new field is added to keep the original semantic ot the 
name, will you be happy with the _byname API?

Benoit
