From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 10 Jun 2015 15:10:29 +0300
Subject: [PATCH v6 5/6] i2c: at91: print hardware version
In-Reply-To: <20150610080553.GO25800@odux.rfo.atmel.com>
References: <cover.1433866582.git.cyrille.pitchen@atmel.com>
 <d1fbf4bce3b470409ef3198f551cfc3f8f22ac78.1433866582.git.cyrille.pitchen@atmel.com>
 <5577428C.3090206@cogentembedded.com>
 <20150610080553.GO25800@odux.rfo.atmel.com>
Message-ID: <55782935.30608@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 6/10/2015 11:05 AM, Ludovic Desroches wrote:

>>> The probe() function now prints the hardware version of the I2C
>>> controller.

>>> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
>>> ---
>>>   drivers/i2c/busses/i2c-at91.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)

>>> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
>>> index 817ae69..6e88b30 100644
>>> --- a/drivers/i2c/busses/i2c-at91.c
>>> +++ b/drivers/i2c/busses/i2c-at91.c
>> [...]
>>> @@ -908,7 +910,8 @@ static int at91_twi_probe(struct platform_device *pdev)
>>>   		return rc;
>>>   	}
>>>
>>> -	dev_info(dev->dev, "AT91 i2c bus driver.\n");
>>> +	dev_info(dev->dev, "AT91 i2c bus driver (version: %#x).\n",

>>     It looks as if you rather print the driver's version. :-)

>  From my point of view, having a version number for a Linux driver would
> be strange

    Not everybody shares your opinion.

> so it's not confusing.

    Oh, it is, from the purely grammatical PoV. Addiung "hardware " to 
"version" (or not mentioning the driver at all) would clear up that confusion.

>>
>>> +		 at91_twi_read(dev, AT91_TWI_VER));
>>>   	return 0;
>>>   }

>> WBR, Sergei

> Regards
> Ludovic

WBR, Sergei
