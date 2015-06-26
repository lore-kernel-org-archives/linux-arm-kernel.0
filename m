From: bamv2005@gmail.com (Bamvor Zhang)
Date: Fri, 26 Jun 2015 21:30:48 +0800
Subject: [PATCH 0/4] arm64: add initial support for the Rockchip rk3368
In-Reply-To: <2154359.YLevLOlh2Y@diego>
References: <1650408.ovnAjReNFJ@diego> <558CD6AE.7030505@gmail.com>
 <2154359.YLevLOlh2Y@diego>
Message-ID: <CAOijeYKpAuBqw0t2RtbWOweGigqxTXO0dNxDGj66SWjFggOYpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko

2015-06-26 15:17 GMT+08:00 Heiko St?bner <heiko@sntech.de>:
> Hi Bamvor,
>
> Am Freitag, 26. Juni 2015, 12:35:58 schrieb Bamvor Jian Zhang:
>> Could I test the code on rk3368 STB such as EKB368, CSA90?
>> Is there some documents about it?
>
> General information on flashing generic Rockchip devices can be found on [0].
> That didn't change for the rk3368 it seems - although a device _might_ be
> locked down to prevent reflashing it seems.
>
> You will of course also need a serial console on the device for the time
> being, so finding the test-points and soldering is probably required.
Thanks, I will try it.

bamvor
>
>
> Heiko
>
>
> [0] http://linux-rockchip.info
>
>
>> On 06/26/2015 02:12 AM, Heiko St?bner wrote:
>> > This adds initial support for the new rk3368 ARM64 soc from Rockchip.
>> >
>> > Overall it looks like someone dropped some A53 cores into a rk3288, so
>> > it shares a lot of peripherals that only differ in details. Therefore
>> > stuff like the mmc, usb, spi, i2c controllers work out of the box.
>> > The support for the gmac already made it into the merge window as well
>> > as the pinctrl support.
>> >
>> > Interestingly, in its core the rk3368 seems trying to be a model student
>> > with psci for smp and using scpi for ddr frequency scaling, although I
>> > currently do not understand how the mailbox works yet. The display
>> > controllers also are only minimally different so I'm hopefully to have
>> > working graphics in the near-ish future :-)
>> >
>> >
>> > As mentioned in the dts patch, this series depends on the dt-binding
>> > header for the clock ids, so will need a shared branch once this is ready.
>> >
>> > Heiko Stuebner (4):
>> >    arm64: add Rockchip architecture entry
>> >    arm64: defconfig: enable ARCH_ROCKCHIP
>> >    arm64: dts: add Rockchip rk3368 core dtsi and board dts for the r88
>> >
>> >      board
>> >
>> >    dt-bindings: document rk3368 R89 board from Rockchip
>> >
>> >   Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>> >   arch/arm64/Kconfig                                 |  10 +
>> >   arch/arm64/boot/dts/Makefile                       |   1 +
>> >   arch/arm64/boot/dts/rockchip/Makefile              |   5 +
>> >   arch/arm64/boot/dts/rockchip/rk3368-r88.dts        | 353 ++++++++
>> >   arch/arm64/boot/dts/rockchip/rk3368.dtsi           | 900
>> >   +++++++++++++++++++++ arch/arm64/configs/defconfig
>> >    |   2 +
>> >   7 files changed, 1275 insertions(+)
>> >   create mode 100644 arch/arm64/boot/dts/rockchip/Makefile
>> >   create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-r88.dts
>> >   create mode 100644 arch/arm64/boot/dts/rockchip/rk3368.dtsi
>
