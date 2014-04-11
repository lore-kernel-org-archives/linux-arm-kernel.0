From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Apr 2014 08:43:50 -0300
Subject: Wrong SPI NOR model detected by mx6sl
In-Reply-To: <20140411002635.GB3837@localhost.localdomain>
References: <CAOMZO5DR00ea=zfr+eM0uh2L5a6QB93g8X48JNkXZZc4UavdZA@mail.gmail.com>
 <201404101807.48238.marex@denx.de>
 <CAOMZO5CBV0tXhbBBFBO=T62nmCn9TenK8BgdAhT8r3b-30u6qg@mail.gmail.com>
 <20140411002635.GB3837@localhost.localdomain>
Message-ID: <CAOMZO5CzMyB=boSO+1QeJbw0yYsa1mME-sMVb6yocJAfnErksA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 9:26 PM, Huang Shijie <shijie8@gmail.com> wrote:
> On Thu, Apr 10, 2014 at 02:16:49PM -0300, Fabio Estevam wrote:
>> Hi Marek,
>>
>> On Thu, Apr 10, 2014 at 1:07 PM, Marek Vasut <marex@denx.de> wrote:
>>
>> > Can you share the JEDEC ID codes that both of the boards actually read from the
>> > SPI NOR ? You can dump those in the m25p80.c driver . That'd be helpful, I
>> > suspect some kind of an "offset" or "polarity inversion" in the SPI
>> > communication causing this.
>>
>> On mx6qsabresd:
>>
>> m25p80 spi0.0: JEDEC id: 0x202016
>> m25p80 spi0.0: m25p32 (4096 Kbytes)
>>
>> On mx6sl-evk:
>>
>> m25p80 spi0.0: JEDEC id: 0x000000
> It seems the kernel can not read out anything from the NOR.
> Please check the pinctrl or the schematic.

Yes, there was a pinmux issue in U-boot and I have fixed it.

SPI NOR is properly detected in U-boot and kernel now.

Regards,

Fabio Estevam
