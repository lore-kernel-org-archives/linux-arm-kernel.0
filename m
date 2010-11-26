From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri, 26 Nov 2010 17:05:41 +0530
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101125165048.GA2367@n2100.arm.linux.org.uk>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<4CEE6AB1.7090404@ti.com>
	<20101125165048.GA2367@n2100.arm.linux.org.uk>
Message-ID: <4CEF9B8D.3010106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2010 10:20 PM, Russell King - ARM Linux wrote:
> Please do:
> 
> make V=1 CFLAGS_KERNEL=-v arch/arm/kernel/swp_emulate.o
> 
> and send the output.  This should show what command arguments are being
> passed to the assembler.

Here's the last line of output from the command above. I've attached the
complete log if anyone's interested.

 /db/omapts/arm-2010q1/bin/../lib/gcc/arm-none-linux-gnueabi/4.4.1/../../../../arm-none-linux-gnueabi/bin/as -v -I/home/userdata/a0393673/mainline/mainline/arch/arm/include -Iinclude -Iarch/arm/mach-omap2/include -Iarch/arm/plat-omap/include -EL -march=armv6 -mfloat-abi=soft -meabi=5 -march=armv7-a -o /tmp/a0393673/ccache/tmp.hash.ubomapldc13.24604.o /tmp/cc4MQyRN.s
GNU assembler version 2.19.51 (arm-none-linux-gnueabi) using BFD version (Sourcery G++ Lite 2010q1-202) 2.19.51.20090709
/tmp/cc4MQyRN.s: Assembler messages:
/tmp/cc4MQyRN.s:339: Error: selected processor does not support ARM mode `ldrexb r7,[r6]'
/tmp/cc4MQyRN.s:340: Error: selected processor does not support ARM mode `strexb r3,r2,[r6]'
make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
make: *** [arch/arm/kernel/swp_emulate.o] Error 2

- Anand



-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: swp-compile-fail.log
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101126/e0dd40b0/attachment-0001.ksh>
