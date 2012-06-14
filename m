From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 14 Jun 2012 19:57:32 +0100
Subject: [PATCH 09/14] i2c: Add Device Tree support to the Nomadik I2C
 driver
In-Reply-To: <20120614183636.GB30185@sirena.org.uk>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD6F0E8.5040606@linaro.org>
 <CACRpkdYxiT-0x4aetMxB2x8SkB+Mmy8rk8uSzgU_anemSayhMw@mail.gmail.com>
 <4FD83AAD.2010701@linaro.org>
 <CACRpkdZC8E6izDpdnWy6DMjOdA6KsqTaPoaq9pErWoNW0Ewytw@mail.gmail.com>
 <4FD88761.9050703@linaro.org> <20120614183636.GB30185@sirena.org.uk>
Message-ID: <4FDA341C.8010501@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/12 19:36, Mark Brown wrote:
> On Wed, Jun 13, 2012 at 01:28:17PM +0100, Lee Jones wrote:
>
>> Device Tree. However, we have just as much control by keeping them
>> in separate structs in the C file and selecting the right one using
>> the compatible sting.
>
> You're not understanding Linus' point.  The compatible string isn't
> useful here because properties like the maximum clock rate of the bus
> depend on the board design, not the silicon.  The controller may be
> perfectly happy to run at a given rate but other devices on the bus or
> the electrical engineering of the PCB itself may restrict this further.

And you're not understanding mine. ;)

You can have multiple compatible strings for a single driver. Which one 
you reference from the Device Tree will dictate which group of settings 
are used, including variation of clock rates.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
