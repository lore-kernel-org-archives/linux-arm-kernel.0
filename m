From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 21 Jul 2016 18:30:52 -0700
Subject: [PATCH v4 0/3] hwmon: xgene: Add support for X-Gene hwmon driver
In-Reply-To: <1469140653-2287-1-git-send-email-hotran@apm.com>
References: <1469140653-2287-1-git-send-email-hotran@apm.com>
Message-ID: <5791774C.4010804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2016 03:37 PM, Hoan Tran wrote:
> This patch set adds hardware temperature and power reading support for
> APM X-Gene SoC using the mailbox communication interface.
> For device tree, it is the standard DT mailbox.
> For ACPI, it is the PCC mailbox.
>
> For ACPI, this patch is built on top and depends on patch[1]:
> [1] http://www.spinics.net/lists/linux-acpi/msg66041.html
>   - [PATCH v3] mailbox: pcc: Support HW-Reduced Communication Subspace type 2
>

One thought: You might consider taking ACPI support out of the driver for now,
and add it back in after the dependent patch was accepted.

Guenter

> v4
>   - Return 0 if driver registers successfully
>
> v3
>   - Order include files alphabetically
>   - Use sign_extend32() to decode temperature
>   - Use DEVICE_ATTR_RO() for temperature and power attributes
>   - Temperature and power attributes start with index 1
>   - Use !!amsg->param2
>   - Fix checkpatch WARNING with --strict flag
>   - Use hwmon_device_register_with_groups()
>   - Check invalid sensor data
>
> v2
>   - Increase power reading accurateness by using 2 registers
> (a register for Watt, another for milli-Watt)
>   - Remove power reading for SoC
>   - Fix review comments from Guenter
>
> v1
>   - Initial
>
> Hoan Tran (3):
>    Documentation: dtb: xgene: Add hwmon dts binding documentation
>    hwmon: xgene: Add hwmon driver
>    arm64: dts: apm: Add X-Gene SoC hwmon to device tree
>
>   .../devicetree/bindings/hwmon/apm-xgene-hwmon.txt  |  14 +
>   Documentation/hwmon/xgene-hwmon                    |  30 +
>   arch/arm64/boot/dts/apm/apm-shadowcat.dtsi         |   5 +
>   arch/arm64/boot/dts/apm/apm-storm.dtsi             |   5 +
>   drivers/hwmon/Kconfig                              |   7 +
>   drivers/hwmon/Makefile                             |   1 +
>   drivers/hwmon/xgene-hwmon.c                        | 755 +++++++++++++++++++++
>   7 files changed, 817 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/apm-xgene-hwmon.txt
>   create mode 100644 Documentation/hwmon/xgene-hwmon
>   create mode 100644 drivers/hwmon/xgene-hwmon.c
>
