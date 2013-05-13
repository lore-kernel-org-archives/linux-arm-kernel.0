From: Benoit.Lecardonnel@synopsys.com (Benoit Lecardonnel)
Date: Mon, 13 May 2013 17:20:55 +0100
Subject: arm64: Platform devices populated from a device_initcall
Message-ID: <519112E7.3040309@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

In the arm64 kernel, function arm64_device_probe 
(arch/arm64/kernel/setup.c) is in charge of populating the platform 
devices defined by the device tree.

Does anyone know why arm64_device_probe is a device_initcall?

This seems to be in conflict with some I2C drivers: see 
drivers/i2c/busses/i2c-designware-platdrv.c for example.
The driver calls platform_driver_probe from a subsys_initcall.
The probe fails because subsys_initcalls are executed before 
device_initcalls.

Maybe arm64_device_probe could be an arch_initcall?

Thanks,
-- 
Benoit Lecardonnel
