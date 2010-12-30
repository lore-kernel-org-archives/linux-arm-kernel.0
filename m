From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 30 Dec 2010 12:42:17 +0800
Subject: [PATCH v2 6/8] arm: mx50: add core functions support except clock
In-Reply-To: <20101229090317.GC8701@shlinux1.ap.freescale.net>
References: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-2-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-3-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-4-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-5-git-send-email-richard.zhao@freescale.com>
	<1293607828-21213-6-git-send-email-richard.zhao@freescale.com>
	<20101229082627.GN14221@pengutronix.de>
	<20101229090317.GC8701@shlinux1.ap.freescale.net>
Message-ID: <AANLkTinPqzq5tDx46dt=mZKeDv-GWvBjKZGXSCLVTjb=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
>> > diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
>> > index 026cd85..e059c30 100644
>> > --- a/arch/arm/mach-mx5/Makefile
>> > +++ b/arch/arm/mach-mx5/Makefile
>> > @@ -4,6 +4,7 @@
>> >
>> > ?# Object file lists.
>> > ?obj-y ? := cpu.o mm.o clock-mx51-mx53.o devices.o
>> don't you want to exclude the mx51/mx53 files for an mx50 build?
> Do you need to rename cpu.c mmc.c and devices.c to add a postfix?
It's better for the guy who will submit mx53 patch to change here.
mx53 don't have any board level code or any specific file yet. I'm not
sure what files will be shared between mx51 and mx53.

Thanks
Richard
>> > +obj-$(CONFIG_SOC_IMX50) += mm-mx50.o
>> >
>> > ?obj-$(CONFIG_CPU_FREQ_IMX) ? ?+= cpu_op-mx51.o
>> > ?obj-$(CONFIG_MACH_MX51_BABBAGE) += board-mx51_babbage.o
