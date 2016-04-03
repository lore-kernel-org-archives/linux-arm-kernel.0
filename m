From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 03 Apr 2016 14:16:09 +0200
Subject: [PATCH 0/8] Various Kirkwood DT warning fixup
In-Reply-To: <8737r2sxwm.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Sun, 03 Apr 2016 14:02:33 +0200")
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
 <8737r2sxwm.fsf@free-electrons.com>
Message-ID: <87y48uripi.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On dim., avril 03 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi Andrew,
>  
>  On dim., avril 03 2016, Andrew Lunn <andrew@lunn.ch> wrote:
>
>> This patchset fixes up various warning from the newer DT compiler
>> currently in net-next.
>>
>> In order to not break everything, i decompiled the generated .dtb
>> files before and after these patches and compared the diff.
>
> Great job!
>
> I will do the same for the armada-* devie tree file.
>
> Could you tell me more about the comparison you did?
>
> Did you use the recenty added dtx_diff tools?
> Or did you check that the binary was the same?
>
> Thanks,
>
> Gregory
>
>>
>> Andrew Lunn (8):
>>   ARM: kirkwood: DT: Remove button address and fixup names
>>   ARM: kirkwood: DT: Remove node address from leds
>>   ARM: kirkwood: DT: Remove address from dsa unit name
>>   ARM: kirkwood: DT: Add address to ethernet-phy unit name
>>   ARM: kirkwood: DT: Fixup pcie DT warnings
>>   ARM: kirkwood: DT: Remove address from gpio-i2c unit name
>>   ARM: kirkwood: DT: Add address to mbus unit name
>>   ARM: kirkwood: DT: Add address go regulator unit name

I added all these patch to mvebu/dt and in mvebu/for-next in order to
allow them to be tested long time enough.

Thanks,

Gregory

>>
>>  arch/arm/boot/dts/kirkwood-6192.dtsi               |  4 ++--
>>  arch/arm/boot/dts/kirkwood-6281.dtsi               |  4 ++--
>>  arch/arm/boot/dts/kirkwood-6282.dtsi               |  4 ++--
>>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |  4 ++--
>>  arch/arm/boot/dts/kirkwood-b3.dts                  | 19 ++++++++---------
>>  arch/arm/boot/dts/kirkwood-blackarmor-nas220.dts   |  4 ++--
>>  arch/arm/boot/dts/kirkwood-cloudbox.dts            |  2 +-
>>  arch/arm/boot/dts/kirkwood-db-88f6281.dts          | 14 ++++++-------
>>  arch/arm/boot/dts/kirkwood-db-88f6282.dts          | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-dir665.dts              | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-dnskw.dtsi              |  6 +++---
>>  arch/arm/boot/dts/kirkwood-ds111.dts               |  2 +-
>>  arch/arm/boot/dts/kirkwood-ds112.dts               |  6 +++++-
>>  arch/arm/boot/dts/kirkwood-ds212.dts               |  2 +-
>>  arch/arm/boot/dts/kirkwood-ds411.dts               |  6 +++++-
>>  arch/arm/boot/dts/kirkwood-ds411slim.dts           |  2 +-
>>  arch/arm/boot/dts/kirkwood-ib62x0.dts              |  4 ++--
>>  arch/arm/boot/dts/kirkwood-iconnect.dts            | 22 +++++++++-----------
>>  arch/arm/boot/dts/kirkwood-km_common.dtsi          | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-laplug.dts              | 19 ++++++++---------
>>  arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 17 ++++++++-------
>>  arch/arm/boot/dts/kirkwood-lsxl.dtsi               | 16 +++++++--------
>>  arch/arm/boot/dts/kirkwood-mplcec4.dts             | 18 ++++++++--------
>>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 24 ++++++++++------------
>>  arch/arm/boot/dts/kirkwood-nas2big.dts             | 18 ++++++++--------
>>  .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 20 ++++++++----------
>>  .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 23 +++++++++------------
>>  arch/arm/boot/dts/kirkwood-netxbig.dtsi            |  8 ++++----
>>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |  4 ++--
>>  arch/arm/boot/dts/kirkwood-nsa310.dts              | 18 ++++++++--------
>>  arch/arm/boot/dts/kirkwood-nsa320.dts              | 18 ++++++++--------
>>  arch/arm/boot/dts/kirkwood-nsa325.dts              | 17 +++++++--------
>>  arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      | 24 ++++++++++------------
>>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |  2 +-
>>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts       |  2 +-
>>  arch/arm/boot/dts/kirkwood-openrd.dtsi             | 14 ++++---------
>>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts   |  2 +-
>>  arch/arm/boot/dts/kirkwood-rd88f6192.dts           | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-rd88f6281-a.dts         |  2 +-
>>  arch/arm/boot/dts/kirkwood-rd88f6281-z0.dts        |  2 +-
>>  arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-rs212.dts               |  6 +++++-
>>  arch/arm/boot/dts/kirkwood-synology.dtsi           | 22 ++++++++------------
>>  arch/arm/boot/dts/kirkwood-t5325.dts               | 22 +++++++++-----------
>>  arch/arm/boot/dts/kirkwood-ts219-6281.dts          |  4 ++--
>>  arch/arm/boot/dts/kirkwood-ts219-6282.dts          | 16 ++++-----------
>>  arch/arm/boot/dts/kirkwood-ts219.dtsi              | 20 ++++++++----------
>>  arch/arm/boot/dts/kirkwood-ts419-6282.dts          | 15 +++-----------
>>  arch/arm/boot/dts/kirkwood-ts419.dtsi              |  4 ++--
>>  arch/arm/boot/dts/kirkwood.dtsi                    |  2 +-
>>  50 files changed, 262 insertions(+), 322 deletions(-)
>>
>> -- 
>> 2.7.0
>>
>
> -- 
> Gregory Clement, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
