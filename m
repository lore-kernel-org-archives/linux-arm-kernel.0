From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 22 Jun 2018 10:51:28 +0200
Subject: [PATCH 3/7] ARM: dts: s5pv210: Add initial DTS for Samsung Galaxy
 S phone.
In-Reply-To: <1851346.itd6mG8ZId@acerlaptop>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-4-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPf8cpJ-pivG9j1sCM3aB_-i2n73MoeQKOd4oXxz976EVw@mail.gmail.com>
 <1851346.itd6mG8ZId@acerlaptop>
Message-ID: <CAJKOXPc+u5eazcn3sO94gjaAtWXzJWW5YUFbGsE5sjXzkfd2Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 June 2018 at 10:42, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> On Friday, June 22, 2018 9:49:42 AM CEST Krzysztof Kozlowski wrote:
>> On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
>> > Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
>>
>> Please add commit message. This can be something as simple as "Add
>> Samsung Galaxy S DTS which is a commercial phone based on Aries
>> family." or something more (e.g. describe what is working).
>>
>> > ---
>> >  arch/arm/boot/dts/Makefile            |  1 +
>> >  arch/arm/boot/dts/s5pv210-galaxys.dts | 72 +++++++++++++++++++++++++++++++++++
>> >  2 files changed, 73 insertions(+)
>> >  create mode 100644 arch/arm/boot/dts/s5pv210-galaxys.dts
>> >
>> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> > index 7e2424957809..522ebdca1d3d 100644
>> > --- a/arch/arm/boot/dts/Makefile
>> > +++ b/arch/arm/boot/dts/Makefile
>> > @@ -846,6 +846,7 @@ dtb-$(CONFIG_ARCH_S3C64XX) += \
>> >         s3c6410-smdk6410.dtb
>> >  dtb-$(CONFIG_ARCH_S5PV210) += \
>> >         s5pv210-aquila.dtb \
>> > +       s5pv210-galaxys.dtb \
>> >         s5pv210-goni.dtb \
>> >         s5pv210-smdkc110.dtb \
>> >         s5pv210-smdkv210.dtb \
>> > diff --git a/arch/arm/boot/dts/s5pv210-galaxys.dts b/arch/arm/boot/dts/s5pv210-galaxys.dts
>> > new file mode 100644
>> > index 000000000000..d435032541a9
>> > --- /dev/null
>> > +++ b/arch/arm/boot/dts/s5pv210-galaxys.dts
>> > @@ -0,0 +1,72 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +
>> > +/dts-v1/;
>> > +#include <dt-bindings/gpio/gpio.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>> > +#include <dt-bindings/input/input.h>
>> > +#include <dt-bindings/interrupt-controller/irq.h>
>>
>> Duplicated inclusion.
>>
>> > +#include "s5pv210-aries.dtsi"
>> > +
>> > +/ {
>> > +       model = "Samsung Galaxy S1 (GT-I9000) based on S5PV210";
>> > +       compatible = "samsung,galaxys", "samsung,aries", "samsung,s5pv210";
>> > +
>> > +       chosen {
>> > +               bootargs = "console=ttySAC2,115200n8 root=/dev/mmcblk2p1 rw rootwait ignore_loglevel earlyprintk";
>>
>> stdout-path = "serial2:115200n8";
>>
>> Rest of bootargs should not be here (they are not HW dependent) unless
>> you cannot configure them through bootloader?
>>
> Stock (proprietary) bootloader is little problematic for me:
> - to access it, You need to build special cable.
> - i wasn't able to boot any kernel newer than 2.6.35/3.0 on it, without following hack/patch
> https://github.com/tom3q/linux/commit/af96ebcba03b607ab93bd5778301890feb038479.patch
>
> I would like to leave those bootargs for now, so anyone can easly test this kernel (just with that one patch),
> without breaking booting existing software, so they could easly go back to stock software by just flashing old kernel.
> Later it'll be removed because there is initial port of mainline u-boot started for both devices
> - currently it can be flashed to device, instead of kernel and boot kernels from onenand/sdcard.
> In this way migration from old kernel to new one will be much easier to users (and won't require special tools/cables/etc).

OK, then move the console to stdout-path and leave the rest with a
comment explaining why they are useful.

Best regards,
Krzysztof
