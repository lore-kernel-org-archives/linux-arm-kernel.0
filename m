From: hemantp@ti.com (Pedanekar, Hemant)
Date: Fri, 19 Aug 2011 09:57:18 +0530
Subject: [PATCH 3/3] TI814X: Create board support and enable build for
	TI8148 EVM
In-Reply-To: <20110815151509.GT12348@atomide.com>
References: <1312479903-22909-1-git-send-email-hemantp@ti.com>
	<20110815151509.GT12348@atomide.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B03ABD26D8D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote on Monday, August 15, 2011 8:45 PM:

> * Hemant Pedanekar <hemantp@ti.com> [110804 20:39]:
>> This patch adds minimal support and build configuration for TI8148 EVM.
>> Also adds support for low level debugging on UART1 console on the EVM. ...
> 
> 
>> +MACHINE_START(TI8148EVM, "ti8148evm")
>> +	/* Maintainer: Texas Instruments */
>> +	.boot_params	= 0x80000100,
>> +	.map_io		= ti8148_evm_map_io,
>> +	.init_early	= ti8148_init_early,
>> +	.init_irq	= ti81xx_init_irq,
>> +	.timer		= &omap3_timer,
>> +	.init_machine	= ti8148_evm_init,
>> +MACHINE_END
> 
> Please just combine this with board-ti8168evm.c by adding the MACHINE_START
> there. It seems the files are identical otherwise?
> 

Tony,
There will be more additions in respective board files such as I2C I/O expander
data, mux handling depending upon the EVM (8168/8148), on board peripherals etc
When these board files would deviate.

What do you suggest to handle such?

Thanks.
   Hemant
