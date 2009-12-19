From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Sat, 19 Dec 2009 14:50:21 +0100
Subject: [PATCH 0/2] mx31moboard for 2.6.33-rc1
In-Reply-To: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1261156293-13981-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1261230621.2067.11.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 2) The MC13783 voltage regulators with boot_on or always_on enabled
> hang the kernel at boot. Remove these options from mx31moboard
> configuration. Sascha, is this a correct behavior or is it a bug ?
> 

Please, enable debug on drivers/spi/imx_spi, drivers/mfd/mc13783-core 
drivers/regulator/mc13783-regulator and drivers/regulator/core 
and let me know what is going on.
I've sent four patches that give voltage selection functionality to 
regulators, but not all are applied at this moment.
I am working on the i.MX31 PDK kernel support, and with those patches
I am able to setup correctly regulators voltages (not modes).

At the moment, the code in kernel can produce a PWGTxDRV lowering 
if you wont to modify something in the mc13783 power-miscellaneous
register.

Alberto!
