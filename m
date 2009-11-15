From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 22:18:36 +0100
Subject: IXP4XX 64MB
In-Reply-To: <20090518170110.GI7042@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 18 May 2009 18:01:10 +0100")
References: <b0438a630905050354r51cce79dua6bfa669bff9ac2d@mail.gmail.com>
	<b0438a630905180838o53881f7eg3dca7c68be6870c6@mail.gmail.com>
	<20090518154453.GC7042@n2100.arm.linux.org.uk>
	<b0438a630905180908y250fe950rd09fc1e5f5b0184@mail.gmail.com>
	<20090518162610.GE7042@n2100.arm.linux.org.uk>
	<b0438a630905180959w23bf6b0au1e147ba4471fafeb@mail.gmail.com>
	<20090518170110.GI7042@n2100.arm.linux.org.uk>
Message-ID: <m3ws1rqyfn.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[a copy, I sent the follow-up mail to the old list address]

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> That was the solution. Now the main question is... why maintaining an
>> specific IXP4XX-Flash resource and driver when the general one works
>> so fine????
>
> A very good and fine question.  There appears to be some explaination
> in drivers/mtd/maps/ixp4xx.c.  I can't comment on its relevence though.

I checked this one (MTD_PHYSMAP on IXP4xx). It works in CPU big-endian
mode. It doesn't work in little-endian mode. Flash cmd/query data
swapping doesn't make it work.

I'll look at it but not at the moment.

Miguel, you're using it in BE mode only, aren't you?
-- 
Krzysztof Halasa
