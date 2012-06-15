From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 15 Jun 2012 10:32:32 +0100
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
 <4FD88761.9050703@linaro.org>
 <20120614183636.GB30185@sirena.org.uk>
 <4FDA341C.8010501@linaro.org>
Message-ID: <20120615093231.GB3898@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 07:57:32PM +0100, Lee Jones wrote:
> On 14/06/12 19:36, Mark Brown wrote:

> >You're not understanding Linus' point.  The compatible string isn't
> >useful here because properties like the maximum clock rate of the bus
> >depend on the board design, not the silicon.  The controller may be
> >perfectly happy to run at a given rate but other devices on the bus or
> >the electrical engineering of the PCB itself may restrict this further.

> And you're not understanding mine. ;)

I think we are (or at least I do)...

> You can have multiple compatible strings for a single driver. Which
> one you reference from the Device Tree will dictate which group of
> settings are used, including variation of clock rates.

I'm certainly well aware of that.  The problem is that the compatible
strings should identify a particular IP or piece of silicon and be
unchanging properties of that hardware - for example, working out how
big a FIFO in a device is from the compatible information is totally
sensible and reasonable.  Things like the I2C bus clock speed on the
other hand depend not on the individual device but on how it's been
integrated into the system so you'd end up saying things like
"nomadik-i2c-100khz-bus" in the compatible string which isn't great.  

If there's something like variation in the maximum speed that can be
supported by the different silicon the driver handles then working that
out from compatible and using it as the default is sensible but that's
not the same thing as providing customisation of the system bus
frequency to the user and if there's only one of those two that's
configurable it should be the system bus frequency.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120615/017b558e/attachment.sig>
