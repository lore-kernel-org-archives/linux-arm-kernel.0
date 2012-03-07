From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 7 Mar 2012 09:45:29 +0800
Subject: [GIT PULL][v3.4] pull request on pxa tree for DT branch
In-Reply-To: <CAN1soZyA8iYJjcWRQoPEP=ksCwVfP6JYqcAdVh_qYjg2oc5XqQ@mail.gmail.com>
References: <CAN1soZyA8iYJjcWRQoPEP=ksCwVfP6JYqcAdVh_qYjg2oc5XqQ@mail.gmail.com>
Message-ID: <CAN1soZzd_6BS=qXKzm8-a+Z=rqC1shJYcoHNwedcHUVhsMo4Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I update the branch according the comments on serial-pxa driver.
Please help to merge these patches.

Thanks
Haojian

The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:

  Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git dt

Haojian Zhuang (6):
      serial: pxa: add OF support
      i2c: pxa: add OF support
      ARM: mmp: enable rtc clk in pxa168
      ARM: mmp: append OF support on pxa168
      ARM: dts: append DTS file of pxa168
      Document: devicetree: add OF documents for arch-mmp

 Documentation/devicetree/bindings/arm/mrvl.txt     |    6 +
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   23 +++++
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   37 ++++++++
 .../devicetree/bindings/rtc/sa1100-rtc.txt         |   17 ++++
 .../devicetree/bindings/serial/mrvl-serial.txt     |    4 +
 arch/arm/boot/dts/pxa168-aspenite.dts              |   38 ++++++++
 arch/arm/boot/dts/pxa168.dtsi                      |   98 ++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig                          |   10 ++
 arch/arm/mach-mmp/Makefile                         |    1 +
 arch/arm/mach-mmp/mmp-dt.c                         |   75 +++++++++++++++
 arch/arm/mach-mmp/pxa168.c                         |    2 +
 drivers/i2c/busses/i2c-pxa.c                       |   95 +++++++++++++++----
 drivers/tty/serial/pxa.c                           |   49 ++++++++---
 13 files changed, 422 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
 create mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt
 create mode 100644 arch/arm/boot/dts/pxa168-aspenite.dts
 create mode 100644 arch/arm/boot/dts/pxa168.dtsi
 create mode 100644 arch/arm/mach-mmp/mmp-dt.c


On Tue, Mar 6, 2012 at 1:51 PM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Hi Arnd,
>
> Please help to pull DT patches on pxa tree. I based it on v3.3-rc6.
>
> The following changes since commit 192cfd58774b4d17b2fe8bdc77d89c2ef4e0591d:
>
> ?Linux 3.3-rc6 (2012-03-03 17:08:09 -0800)
>
> are available in the git repository at:
> ?git://github.com/hzhuang1/linux.git dt
>
> Haojian Zhuang (6):
> ? ? ?serial: pxa: add OF support
> ? ? ?i2c: pxa: add OF support
> ? ? ?ARM: mmp: enable rtc clk in pxa168
> ? ? ?ARM: mmp: append OF support on pxa168
> ? ? ?ARM: dts: append DTS file of pxa168
> ? ? ?Document: devicetree: add OF documents for arch-mmp
>
> ?Documentation/devicetree/bindings/arm/mrvl.txt ? ? | ? ?6 +
> ?.../devicetree/bindings/gpio/mrvl-gpio.txt ? ? ? ? | ? 23 +++++
> ?Documentation/devicetree/bindings/i2c/mrvl-i2c.txt | ? 37 ++++++++
> ?.../devicetree/bindings/rtc/sa1100-rtc.txt ? ? ? ? | ? 17 ++++
> ?.../devicetree/bindings/serial/mrvl-serial.txt ? ? | ? ?4 +
> ?arch/arm/boot/dts/pxa168-aspenite.dts ? ? ? ? ? ? ?| ? 38 ++++++++
> ?arch/arm/boot/dts/pxa168.dtsi ? ? ? ? ? ? ? ? ? ? ?| ? 98 ++++++++++++++++++++
> ?arch/arm/mach-mmp/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? 10 ++
> ?arch/arm/mach-mmp/Makefile ? ? ? ? ? ? ? ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mmp/mmp-dt.c ? ? ? ? ? ? ? ? ? ? ? ? | ? 75 +++++++++++++++
> ?arch/arm/mach-mmp/pxa168.c ? ? ? ? ? ? ? ? ? ? ? ? | ? ?2 +
> ?drivers/i2c/busses/i2c-pxa.c ? ? ? ? ? ? ? ? ? ? ? | ? 95 +++++++++++++++----
> ?drivers/tty/serial/pxa.c ? ? ? ? ? ? ? ? ? ? ? ? ? | ? 52 ++++++++---
> ?13 files changed, 425 insertions(+), 33 deletions(-)
> ?create mode 100644 Documentation/devicetree/bindings/arm/mrvl.txt
> ?create mode 100644 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
> ?create mode 100644 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
> ?create mode 100644 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
> ?create mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt
> ?create mode 100644 arch/arm/boot/dts/pxa168-aspenite.dts
> ?create mode 100644 arch/arm/boot/dts/pxa168.dtsi
> ?create mode 100644 arch/arm/mach-mmp/mmp-dt.c
