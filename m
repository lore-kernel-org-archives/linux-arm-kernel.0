From: marex@denx.de (Marek Vasut)
Date: Fri, 11 Apr 2014 13:59:26 +0200
Subject: Wrong SPI NOR model detected by mx6sl
In-Reply-To: <CAOMZO5CzMyB=boSO+1QeJbw0yYsa1mME-sMVb6yocJAfnErksA@mail.gmail.com>
References: <CAOMZO5DR00ea=zfr+eM0uh2L5a6QB93g8X48JNkXZZc4UavdZA@mail.gmail.com>
 <20140411002635.GB3837@localhost.localdomain>
 <CAOMZO5CzMyB=boSO+1QeJbw0yYsa1mME-sMVb6yocJAfnErksA@mail.gmail.com>
Message-ID: <201404111359.26723.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, April 11, 2014 at 01:43:50 PM, Fabio Estevam wrote:
> On Thu, Apr 10, 2014 at 9:26 PM, Huang Shijie <shijie8@gmail.com> wrote:
> > On Thu, Apr 10, 2014 at 02:16:49PM -0300, Fabio Estevam wrote:
> >> Hi Marek,
> >> 
> >> On Thu, Apr 10, 2014 at 1:07 PM, Marek Vasut <marex@denx.de> wrote:
> >> > Can you share the JEDEC ID codes that both of the boards actually read
> >> > from the SPI NOR ? You can dump those in the m25p80.c driver . That'd
> >> > be helpful, I suspect some kind of an "offset" or "polarity
> >> > inversion" in the SPI communication causing this.
> >> 
> >> On mx6qsabresd:
> >> 
> >> m25p80 spi0.0: JEDEC id: 0x202016
> >> m25p80 spi0.0: m25p32 (4096 Kbytes)
> >> 
> >> On mx6sl-evk:
> >> 
> >> m25p80 spi0.0: JEDEC id: 0x000000
> > 
> > It seems the kernel can not read out anything from the NOR.
> > Please check the pinctrl or the schematic.
> 
> Yes, there was a pinmux issue in U-boot and I have fixed it.
> 
> SPI NOR is properly detected in U-boot and kernel now.

This means there's also a pinmux issue in kernel, did you fix it in kernel as 
well please ?

Best regards,
Marek Vasut
