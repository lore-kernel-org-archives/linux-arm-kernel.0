From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 May 2015 18:06:53 +0200
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <2419398.cbLWQC7K5f@wuerfel>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <20150519101615.GA2067@n2100.arm.linux.org.uk>
 <bb773210f5f7068a8cba2c283422676c@agner.ch> <2419398.cbLWQC7K5f@wuerfel>
Message-ID: <b41ebeb9d62b9c49faec6500f73460b9@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-19 13:50, Arnd Bergmann wrote:
> On Tuesday 19 May 2015 13:23:22 Stefan Agner wrote:
>> On 2015-05-19 12:16, Russell King - ARM Linux wrote:
<snip>
>> Not sure how we can deal with the EFM32 vs. IMX changes... Patches 08-10
>> has no dependencies on the clock changes which Thomas merged. They could
>> go through whatever EFM32 is merged normally (last time Arnd directly
>> merged from Uwe), and then Shawn could base the rest of the changes on
>> that too?
> 
> Do you have a dependency on patch 10 (the one for EFM32) in your later
> patches?

Unfortunately, there is a dependency on that patch: I change the default
of UNCOMPRESS_INCLUDE to debug/uncompress.h for all ARM_SINGLE_ARMV7M
platforms. Without that patch, it would default to mach/uncompress.h,
which does not exist for MACH_MXC/SOC_VF610.

> 
> If not, you can send the other ones to Shawn, so I pull them as
> a branch, and then I apply that on top of the merges. I have also
> merged two other ARMv7M platforms for 4.2 now (both in next/soc),
> so we should do the same change for those as well, and I'd rather
> apply a patch for that, than merge a branch that is based on
> next/soc.

I guess, in that case, you need to take the others too? (08/09?)

--
Stefan
