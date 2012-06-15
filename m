From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jun 2012 11:32:33 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <4FDA341C.8010501@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD6F0E8.5040606@linaro.org>
 <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com>
 <4FD83AAD.2010701@linaro.org>
 <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
 <4FD88761.9050703@linaro.org> <20120614183636.GB30185@sirena.org.uk>
 <4FDA341C.8010501@linaro.org>
Message-ID: <20120615103233.GA19046@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 07:57:32PM +0100, Lee Jones wrote:
> On 14/06/12 19:36, Mark Brown wrote:
>> On Wed, Jun 13, 2012 at 01:28:17PM +0100, Lee Jones wrote:
>>
>>> Device Tree. However, we have just as much control by keeping them
>>> in separate structs in the C file and selecting the right one using
>>> the compatible sting.
>>
>> You're not understanding Linus' point.  The compatible string isn't
>> useful here because properties like the maximum clock rate of the bus
>> depend on the board design, not the silicon.  The controller may be
>> perfectly happy to run at a given rate but other devices on the bus or
>> the electrical engineering of the PCB itself may restrict this further.
>
> And you're not understanding mine. ;)
>
> You can have multiple compatible strings for a single driver. Which one  
> you reference from the Device Tree will dictate which group of settings  
> are used, including variation of clock rates.

However, if you list these settings separately, rather than selecting them
based on a compatible string, it means when other board designs come along,
you don't have to modify the kernel code to provide yet another compatible
to settings translation in the code - you can keep all that information
entirely within DT with no kernel code mods.

I thought that was partly the point of DT...
