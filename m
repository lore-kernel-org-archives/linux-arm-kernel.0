From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 27 Feb 2012 09:32:30 +0800
Subject: [PATCH v3] pxa/hx4700: Fix PXA_GPIO_IRQ_BASE/IRQ_NUM values
In-Reply-To: <CA+gwMccFY1KLn4=cHPkO-dOHz1+8EdPcc=FaCJ0hL5+uMYVEew@mail.gmail.com>
References: <1327967449.72659.YahooMailClassic@web29002.mail.ird.yahoo.com>
 <CA+gwMccFY1KLn4=cHPkO-dOHz1+8EdPcc=FaCJ0hL5+uMYVEew@mail.gmail.com>
Message-ID: <CAN1soZzXuDd0uU=1WYrgPkQ5hXhgrv-Kzq-_Yct7-XcKG35Z4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2012 at 7:04 PM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> On Tue, Jan 31, 2012 at 12:50 AM, Paul Parsons <lost.distance@yahoo.com> wrote:
>> The hx4700 platform has 72 board gpios: 64 ASIC3 gpios numbered 192..255, and
>> 8 EGPIO gpios numbered 256..263 (plus a 9th which is not used).
>> Thus the new CONFIG_ARCH_NR_GPIO config option must be set to 264.
>>
>> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
>
> Acked-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> regards
> Philipp

Hi Paul,

I found this patch is broken. I failed to apply it. You can check it
in below. Could you help to format and paste it again?

Thanks
Haojian

The hx4700 platform has 72 board gpios: 64 ASIC3 gpios numbered 192..255, a=
nd=0A8 EGPIO gpios numbered 256..263 (plus a 9th which is not used).=0AThus=
 the new CONFIG_ARCH_NR_GPIO config option must be set to 264.=0A=0ASigned-=
off-by: Paul Parsons <lost.distance@yahoo.com>=0A---=0A=0AV3:=0ADescription=
 change: 64 ASIC3 gpios + 8 EGPIO gpios =3D 72 board gpios, not 70.=0A=0Adi=
ff -ru clean-3.3-rc1/arch/arm/Kconfig linux-3.3-rc1/arch/arm/Kconfig=0A--- =
clean-3.3-rc1/arch/arm/Kconfig=092012-01-19 23:04:48.000000000 +0000=0A+++ =
linux-3.3-rc1/arch/arm/Kconfig=092012-01-30 17:11:35.897518763 +0000=0A@@ -=
1580,6 +1580,7 @@=0A =09int=0A =09default 1024 if ARCH_SHMOBILE || ARCH_TEG=
RA=0A =09default 350 if ARCH_U8500=0A+=09default 264 if MACH_H4700=0A =09de=
fault 0=0A =09help=0A =09  Maximum number of GPIOs in the system.=0A
