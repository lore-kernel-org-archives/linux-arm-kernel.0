From: liu.y.victor@gmail.com (Liu Ying)
Date: Wed, 23 Jan 2013 21:40:26 +0800
Subject: [PATCH 1/2] misc/at24: Add at24c512b eeprom support
In-Reply-To: <20130123125001.GG16264@pengutronix.de>
References: <1358922764-31654-1-git-send-email-Ying.Liu@freescale.com>
 <CACRpkdbQcyO82Z7+v61VmJBOHuPVT2ZphQQT7OpZ9edYbho5YQ@mail.gmail.com>
 <20130123125001.GG16264@pengutronix.de>
Message-ID: <CA+8Hj80=Mk1gMSC9gcRT_XPFrEdRxifaB9FNMtkn3BkUkv9bGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/23 Wolfram Sang <w.sang@pengutronix.de>:
> On Wed, Jan 23, 2013 at 01:24:52PM +0100, Linus Walleij wrote:
>> On Wed, Jan 23, 2013 at 7:32 AM, Liu Ying <Ying.Liu@freescale.com> wrote:
>>
>> > This patch adds at24c512b eeprom support.
>> > The datasheet of at24c512b can be found at:
>> > http://www.alldatasheet.com/datasheet-pdf/pdf/
>> > 256958/ATMEL/AT24C512B-TH-B.html
>> >
>> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
>>
>> Arnd Bergmann is the misc maintainer, route this by him.
>
> I usually take at24 patches via my I2C tree.
>
> But not this one, though. The 512b can equally use the 512 entry. The
> devicetree should contain both entries, the 512 one as a fallback. (And
> the vendor is not "at24"!)

There are some difference between 24c512 and 24c512b about the system
reset procedure, according to the two devices' spec:
24c512b:(a) Create a start bit condition, (b)clock 9 cycles, (c)
create another start bit followed by stop bit condition.
24c512:(a) Clock up to 9 cycles, (b) look for SDA high in each cycle
while SCL is high and then, (c) create a start condition as SDA is
high.
Could this be a reason to add an entry for 24c512b?

About the vendor name, I took the at24c32 node in
arch/arm/boot/dts/imx28-evk.dts as a reference:

                                at24 at 51 {
                                        compatible = "at24,24c32";
                                        pagesize = <32>;
                                        reg = <0x51>;
                                };

Now, I think the correct vendor name should be "at" or "atmel".

Thanks.

>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang                |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |



-- 
Best Regards,
Liu Ying
