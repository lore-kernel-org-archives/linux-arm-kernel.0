From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 03 Oct 2011 11:49:11 +0200
Subject: [PATCH 3/3] tty/serial: atmel_serial: __devinit_p for probe
	function
In-Reply-To: <4355360.0xR5ZY7sEk@wuerfel>
References: <cd489c1d28c26624d6b68399d222aec371045e53.1317634987.git.nicolas.ferre@atmel.com>
	<d7c2023edfbeb3d21bccd5b997f7806874b01b04.1317636473.git.nicolas.ferre@atmel.com>
	<4355360.0xR5ZY7sEk@wuerfel>
Message-ID: <4E898517.6020104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2011 11:36 AM, Arnd Bergmann :
> On Monday 03 October 2011 12:11:19 Nicolas Ferre wrote:
>>  }
>>  
>>  static struct platform_driver atmel_serial_driver = {
>> -       .probe          = atmel_serial_probe,
>> +       .probe          = __devinit_p(atmel_serial_probe),
>>         .remove         = __devexit_p(atmel_serial_remove),
>>         .suspend        = atmel_serial_suspend,
>>         .resume         = atmel_serial_resume,
> 
> Still wrong: __devinit_p does not exist and is not needed.

OMG, the not-enouth-coffee syndrome... twice!

So we forget all this and I try to increase my signal/noise ratio ;-)

Bye,
-- 
Nicolas Ferre
