From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 11 Aug 2015 14:54:33 +0530
Subject: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
In-Reply-To: <20150811090342.GG10748@sirena.org.uk>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com>
 <1437568344-18889-4-git-send-email-fcooper@ti.com> <55B22681.3060000@ti.com>
 <55C9380D.1060802@ti.com> <55C99D0D.9050605@ti.com>
 <20150811090342.GG10748@sirena.org.uk>
Message-ID: <55C9BF51.5080401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 August 2015 02:33 PM, Mark Brown wrote:
> On Tue, Aug 11, 2015 at 12:28:21PM +0530, Sekhar Nori wrote:
>> On Tuesday 11 August 2015 05:17 AM, Franklin S Cooper Jr. wrote:
> 
>>> ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.
> 
>> Mark, can you apply this patch to your tree as well? Thats the preferred
>> route for me.
> 
>> If thats not an option for you, can you confirm that the topic/davinci
>> branch of your spi tree is an immutable commit I can base my pull
>> request to ARM-SoC on?
> 
> Why would there be any interdependency between the the two trees, that
> would be very unusual?  Adding a new value to DT doesn't need the kernel
> to understand it and the driver should be compatible with existing DTs.
> If there *is* some dependency that suggests the driver update has
> problems...

The dependency is because of platform data. Patch 2/4 adds a new
platform data member 'prescaler_limit' which this patch populates for
DaVinci devices using legacy booting.

> In any case I don't have a copy of the patch any more.

I can resend this patch to you with my ack included.

Thanks,
Sekhar
