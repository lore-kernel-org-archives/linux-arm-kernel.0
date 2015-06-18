From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 Jun 2015 16:04:48 +0200
Subject: ARMADA-XP cpu1 .. cpu3 does not come online
In-Reply-To: <20150618133607.GB312@lunn.ch>
References: <20150618123833.GA28005@t440.home> <20150618133607.GB312@lunn.ch>
Message-ID: <20150618160448.011bf726@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Thu, 18 Jun 2015 15:36:07 +0200, Andrew Lunn wrote:

> > Uncompressing Linux... done, booting the kernel.                               
> > [    0.000000] Booting Linux on physical CPU 0x0                               
> > [    0.000000] Linux version 4.0.5-00001-g8b87c3c (peter at t440) (gcc version 4.95
> > [    0.000000] CPU: ARMv7 Processor [562f5842] revision 2 (ARMv7), cr=10c5387d 
> > [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache 
> > [    0.000000] Machine model: AXP-TEST-BOARD 
> > [    0.000000] bootconsole [earlycon0] enabled
> > [    0.000000] Truncating RAM at 0x00000000-0xffffffff to -0x2f800000 
> > 
> > ^^ This is worrying to me, firstly because memory is being truncated down, secondly because my dts file only specifies memory from 0x00000000 to 0xf000000 (see attached dts file)
> 
> 0x2f800000 suggests you have an old boot loader, with IO at
> 0xd000,0000. Upgrading to a newer uboot will allow you to use more of
> the 4G of RAM. It might also fix your SMP issue.

Nope, I don't think so: his DT is using 0xf1000000 and the platform
boots successfully (serial port working). He is also using 0xf1012000
as the UART earlyprintk physical address, and it boots. So his internal
registers are set at 0xf1000000.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
