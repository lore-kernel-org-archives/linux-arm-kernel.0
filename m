From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 10:52:16 +0200
Subject: On mini2440 IO mappings.
In-Reply-To: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
References: <CAM2a4uxNKhD_+zr7mZOV0eR7u_VTCSZyEcsj_uNA5MuuKPFbDQ@mail.gmail.com>
Message-ID: <3308480.LZZ0YkAPVH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 13:11:04 mind entropy wrote:
> 
>    I am going through the mini2440 source code for my understanding of
> porting an ARM board to linux. I have a doubt regarding initial
> mappings sizes of the IRQ, GPIO etc. In
> arch/arm/mach-s3c24xx/include/mach/map.h S3C24XX_SZ_IRQ is set to
> SZ_1M but in the documentation (Pg 1-27 of s3c2440.pdf datasheet) the
> physical address extends from 0X4A000000 to 0X4A00001C. So shouldn't a
> size of 4K(small page) or 1K(tiny page) be enough?

Yes, that would be enough, but I think it makes little difference
either way.

What kind of board port are you doing? New ports would look quite
different from s3c24xx/mini2440, so it might not be the best
example to look at.

	Arnd
