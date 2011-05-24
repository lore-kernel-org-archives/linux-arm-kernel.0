From: paulo@nlink.com.br (Paulo Fragoso)
Date: Tue, 24 May 2011 01:31:05 -0300
Subject: External serial 8250/16550
In-Reply-To: <4DD579EB.50609@nlink.com.br>
References: <4DB44883.3000608@nlink.com.br>	<BANLkTinMrZvO_bNcAKXvaa_pXE+jOxO2uw@mail.gmail.com>	<4DC3F035.9030208@nlink.com.br>	<4DC8AFF9.9030508@nlink.com.br>	<4DCB449C.8060808@nlink.com.br>
	<4DD579EB.50609@nlink.com.br>
Message-ID: <4DDB3489.2020809@nlink.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-05-2011 17:13, Paulo Fragoso wrote:
>
> This explain constant output on COMA from TL16C2550 and COMB is 
> detected at boot time but doesn't work.
>
> I will research what can be happening but what can be wrong with NCS1 
> and NCS2?

All is working at boot time and NCS1 was correctly programed in bootstrap.

But no data out at serial line I'm testing enabling getty in inittab.

NCS1, NCS2, IOW and IOR are working how expected by the SMC config:

static struct sam9_smc_config tms_uart_smc_config = {
     .ncs_read_setup   = 0,
     .nrd_setup        = 2,
     .ncs_write_setup  = 0,
     .nwe_setup        = 2,

     .ncs_read_pulse   = 5,
     .nrd_pulse        = 4,
     .ncs_write_pulse  = 4,
     .nwe_pulse        = 3,

     .read_cycle       = 10,
     .write_cycle      = 9,

     .mode             = AT91_SMC_READMODE | AT91_SMC_WRITEMODE | 
AT91_SMC_EXNWMODE_DISABLE | AT91_SMC_DBW_8 | AT91_SMC_BAT_WRITE,
     .tdf_cycles       = 3,
};

Why isn't there any data on TX for COMA or COMB?

Paulo.
