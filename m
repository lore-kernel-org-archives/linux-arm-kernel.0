From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 10 Apr 2014 14:16:49 -0300
Subject: Wrong SPI NOR model detected by mx6sl
In-Reply-To: <201404101807.48238.marex@denx.de>
References: <CAOMZO5DR00ea=zfr+eM0uh2L5a6QB93g8X48JNkXZZc4UavdZA@mail.gmail.com>
 <201404101807.48238.marex@denx.de>
Message-ID: <CAOMZO5CBV0tXhbBBFBO=T62nmCn9TenK8BgdAhT8r3b-30u6qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Thu, Apr 10, 2014 at 1:07 PM, Marek Vasut <marex@denx.de> wrote:

> Can you share the JEDEC ID codes that both of the boards actually read from the
> SPI NOR ? You can dump those in the m25p80.c driver . That'd be helpful, I
> suspect some kind of an "offset" or "polarity inversion" in the SPI
> communication causing this.

On mx6qsabresd:

m25p80 spi0.0: JEDEC id: 0x202016
m25p80 spi0.0: m25p32 (4096 Kbytes)

On mx6sl-evk:

m25p80 spi0.0: JEDEC id: 0x000000
m25p80 spi0.0: found mr25h256, expected m25p32
m25p80 spi0.0: mr25h256 (32 Kbytes)

Will need to dump the SPI registers to understand why mx6sl behaves like this.

Thanks,

Fabio Estevam
