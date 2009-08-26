From: dhaval.vasa@einfochips.com (Dhaval Vasa)
Date: Wed, 26 Aug 2009 19:33:35 +0530
Subject: [PATCH] ARM: OpenRD base: Initialize PCI express, i2c and UART 1
In-Reply-To: <20090826155708.3dfe4ad2@marrow.netinsight.se>
References: <20090826094230.574eda24@marrow.netinsight.se>
	<20090826155708.3dfe4ad2@marrow.netinsight.se>
Message-ID: <4A9540B7.1000404@einfochips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Kagstrom wrote:
> On Wed, 26 Aug 2009 09:42:30 +0200
> Simon Kagstrom <simon.kagstrom@netinsight.net> wrote:
> 
>> ARM: OpenRD base: Initialize PCI express, i2c and UART 1
> 
>> diff --git a/arch/arm/mach-kirkwood/openrd_base-setup.c b/arch/arm/mach-kirkwood/openrd_base-setup.c
>> index f9a2166..003db06 100644
>> --- a/arch/arm/mach-kirkwood/openrd_base-setup.c
>> +++ b/arch/arm/mach-kirkwood/openrd_base-setup.c
>> @@ -64,6 +64,7 @@ static void __init openrd_base_init(void)
>>  	kirkwood_mpp_conf(openrd_base_mpp_config);
>>  
>>  	kirkwood_uart0_init();
>> +	kirkwood_uart1_init();
> 
> After looking at the openrd design I realised that this might not be
> such a hot idea. The UART1 pins are multiplexed with the SD card, so
> I'm not sure what happens if you have both of these initialized at the
> same time.
> 
> Anyone knows how Kirkwood behaves when on-board devices use pins which
> are multiplexed for something else?
> 

On Marvell LSP, default SD card is selected; and user has an option of 
selecting UART (either RS-232 or RS-485) using command line argument and 
u-boot environment variable.

Even if you initialize both at the same time, there is no issue as 
selection of SD/UART1 is based on MPP (GPIO) pin - 28, 34.

I am working on patch to add SD/UART1 selection for in-tree.  So, you 
can keep this init routine.

- Dhaval
-- 
_____________________________________________________________________
Disclaimer: This e-mail message and all attachments transmitted with it
are intended solely for the use of the addressee and may contain legally
privileged and confidential information. If the reader of this message
is not the intended recipient, or an employee or agent responsible for
delivering this message to the intended recipient, you are hereby
notified that any dissemination, distribution, copying, or other use of
this message or its attachments is strictly prohibited. If you have
received this message in error, please notify the sender immediately by
replying to this message and please delete it from your computer. Any
views expressed in this message are those of the individual sender
unless otherwise stated.Company has taken enough precautions to prevent
the spread of viruses. However the company accepts no liability for any
damage caused by any virus transmitted by this email.
_____________________________________________________________________
 
