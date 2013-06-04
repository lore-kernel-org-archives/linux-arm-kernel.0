From: mindentropy@gmail.com (mind entropy)
Date: Tue, 4 Jun 2013 14:59:17 +0530
Subject: On mini2440 IO mappings.
In-Reply-To: <3308480.LZZ0YkAPVH@wuerfel>
References: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
 <3308480.LZZ0YkAPVH@wuerfel>
Message-ID: <CAM2a4uw_mq=NZHrg32KRf7js8+3iC59SB1NPdP8EwCov7z0DnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 4, 2013 at 2:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 June 2013 13:11:04 mind entropy wrote:

>> arch/arm/mach-s3c24xx/include/mach/map.h S3C24XX_SZ_IRQ is set to
>> SZ_1M but in the documentation (Pg 1-27 of s3c2440.pdf datasheet) the
>> physical address extends from 0X4A000000 to 0X4A00001C. So shouldn't a
>> size of 4K(small page) or 1K(tiny page) be enough?
>
> Yes, that would be enough, but I think it makes little difference
> either way.
>

Just to clarify, this would create an overlap i.e. 2 different virtual
address will point to the same physical address right?

> What kind of board port are you doing? New ports would look quite
> different from s3c24xx/mini2440, so it might not be the best
> example to look at.
>
>         Arnd

I am just trying my hand on the minimal bootup of the board. I am
looking at the existing port and trying to write my own. I am using
the 3.9 vanilla kernel with pengutronix patches.
