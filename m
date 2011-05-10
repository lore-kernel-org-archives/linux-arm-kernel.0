From: paulo@nlink.com.br (Paulo Fragoso)
Date: Tue, 10 May 2011 00:24:41 -0300
Subject: External serial 8250/16550
In-Reply-To: <4DC3F035.9030208@nlink.com.br>
References: <4DB44883.3000608@nlink.com.br>	<BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>
	<4DC3F035.9030208@nlink.com.br>
Message-ID: <4DC8AFF9.9030508@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06-05-2011 09:57, Paulo Fragoso wrote:
> Em 26/04/2011 13:39, Andrew Victor escreveu:
>
>>
>> Those AT91_SMC registers and bits only exist on the AT91RM9200,
>> whereas you're using a SAM9-based processor.
>>
>> You should be configuring the memory controller by:
>> #include<mach/at91sam9_smc.h>
>> #include "sam9_smc.h"
>>
>> and declaring a "struct sam9_smc_config" with all the setting&
>
> I changed the code following TL16C2550 datasheet and now I am using
> correct registers for AT91sam:
>
> static struct sam9_smc_config tms_uart_smc_config = {
> .ncs_read_setup = 0,
> .nrd_setup = 2,
> .ncs_write_setup = 0,
> .nwe_setup = 2,
>
> .ncs_read_pulse = 5,
> .nrd_pulse = 4,
> .ncs_write_pulse = 4,
> .nwe_pulse = 3,
>
> .read_cycle = 10,
> .write_cycle = 9,
>
> .mode = AT91_SMC_READMODE | AT91_SMC_WRITEMODE |
> AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8 | AT91_SMC_BAT_WRITE,
> .tdf_cycles = 3,
> };
>

I found an error on sam9_smc_configure call, now first (or second) 
serial was detected:

Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x30000000 (irq = 97) is a 16550A

Whole code is on:

http://users.nlink.com.br/~paulo/TMS/20110509/board-sweda_tms2.c

Many Thanks,
Paulo.
