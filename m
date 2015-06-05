From: jun.nie@linaro.org (Jun Nie)
Date: Fri, 5 Jun 2015 09:45:34 +0800
Subject: [PATCH v6 0/4] Add basic ZTE zx296702 SOC support
In-Reply-To: <20150604182739.GH490@codeaurora.org>
References: <1433388063-13682-1-git-send-email-jun.nie@linaro.org>
 <20150604182739.GH490@codeaurora.org>
Message-ID: <CABymUCOzztcYDFO_7qQthTUvw=yjFweptFE6qWkXq1vW+nq4og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-06-05 2:27 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 06/04, Jun Nie wrote:
>> Changes vs v5:
>>   - Remove redundant code and polish return value in clock driver.
>>
>> Changes vs v4:
>>   - Fix issues in clock driver that Stephen found.
>>   - Remove initramfs in defconfig to avoid overriding test config.
>>   - Drop patches that already merged into ARM next/soc.
>>
>> Jun Nie (4):
>>   dt-bindings: Add #defines for ZTE ZX296702 clocks
>>   clk: zx: add clock support to zx296702
>>   ARM: dts: zx: add an initial zx296702 dts and doc
>>   ARM: zx: Add basic defconfig support for ZX296702
>
> clk patch looks ok. If this doesn't go into 4.2 please consider
> sending the clk driver through the clk tree.

That's OK. Do you mean I need to send clk patches to clk mail list, or
you can just take it into your branch? I will wait for they are
merged, then post other ARM patches again because ARM patches depends
on clk header file.

>
>>
>>  Documentation/devicetree/bindings/arm/zte.txt      |  15 +
>>  .../devicetree/bindings/clock/zx296702-clk.txt     |  35 ++
>>  Documentation/devicetree/bindings/serial/pl011.txt |   2 +-
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  arch/arm/boot/dts/zx296702-ad1.dts                 |  48 ++
>>  arch/arm/boot/dts/zx296702.dtsi                    | 139 +++++
>>  arch/arm/configs/zx_defconfig                      | 129 ++++
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/zte/Makefile                           |   2 +
>>  drivers/clk/zte/clk-pll.c                          | 172 ++++++
>>  drivers/clk/zte/clk-zx296702.c                     | 657 +++++++++++++++++++++
>>  drivers/clk/zte/clk.h                              |  32 +
>>  include/dt-bindings/clock/zx296702-clock.h         | 170 ++++++
>>  14 files changed, 1403 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/zte.txt
>>  create mode 100644 Documentation/devicetree/bindings/clock/zx296702-clk.txt
>>  create mode 100644 arch/arm/boot/dts/zx296702-ad1.dts
>>  create mode 100644 arch/arm/boot/dts/zx296702.dtsi
>>  create mode 100644 arch/arm/configs/zx_defconfig
>>  create mode 100644 drivers/clk/zte/Makefile
>>  create mode 100644 drivers/clk/zte/clk-pll.c
>>  create mode 100644 drivers/clk/zte/clk-zx296702.c
>>  create mode 100644 drivers/clk/zte/clk.h
>>  create mode 100644 include/dt-bindings/clock/zx296702-clock.h
>>
>> --
>> 1.9.1
>>
>
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
