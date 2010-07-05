From: philippe.langlais@stericsson.com (Philippe Langlais)
Date: Mon, 5 Jul 2010 09:39:34 +0200
Subject: [PATCH 5/6] U6715 8250 serial like driver
In-Reply-To: <20100624143129.GE6523@n2100.arm.linux.org.uk>
References: <1274948852-9179-1-git-send-email-philippe.langlais@stericsson.com>
	<1274948852-9179-6-git-send-email-philippe.langlais@stericsson.com>
	<20100624143129.GE6523@n2100.arm.linux.org.uk>
Message-ID: <4C318C36.9010501@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 06/24/10 16:31, Russell King - ARM Linux wrote:
> On Thu, May 27, 2010 at 10:27:31AM +0200, Philippe Langlais wrote:
>    
>> Some modifications in 16550A/8250 serial driver
>> and clock management specificity
>>      
> Can't say much about this; you need to get people interested in serial to
> review this.  The comments about header file ordering apply.
>
>    
>> @@ -199,10 +199,16 @@ static const struct serial8250_config uart_config[] = {
>>   	},
>>   	[PORT_16550A] = {
>>   		.name		= "16550A",
>> +#if defined(CONFIG_SERIAL_8250_U6)
>> +		.fifo_size	= 64,
>> +		.tx_loadsz	= 64,
>> +		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
>>      
> If you have auto flow control, then you don't have a 16550A.  You have
> something that is compatible with a 16550A - maybe it's more closely
> related to a 16750?
>    
I'll send our serial driver to the LKML and discuss about that.

Regards
Philippe
