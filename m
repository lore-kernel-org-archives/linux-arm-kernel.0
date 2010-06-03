From: sedji.gaouaou@atmel.com (Sedji Gaouaou)
Date: Thu, 03 Jun 2010 14:46:26 +0200
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4C050D97.4000404@visionsystems.de>
References: <4B85789D.6000704@billgatliff.com>
	<4B864C66.6060209@atmel.com>	<4B867108.2050806@billgatliff.com>
	<4B86AA29.8010806@atmel.com>	<4B89E1BB.6090504@billgatliff.com>
	<4B8B9849.5040203@atmel.com> <4B96571A.3040403@visionsystems.de>
	<4B96668E.6090805@atmel.com> <4B975C9A.3020106@visionsystems.de>
	<4B97602C.6070608@atmel.com> <4B97BD8C.3030502@visionsystems.de>
	<4B97C086.2080404@atmel.com> <4C050D97.4000404@visionsystems.de>
Message-ID: <4C07A422.5070505@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yegor,

It is an error indeed, it should be a debug message.

Regards,
Sedji

Le 6/1/2010 3:39 PM, Yegor Yefremov a ?crit :
> Hi,
>
>>> When do you think the driver could hit the mainline kernel? Till
>>> 2.6.35 open window?
>>
>> It has been acked, but I don't know when it will be in the mainline kernel.
>
> have just tested 2.6.35-rc1 with mainline ac97 driver and found this issue. During playback I see following output on the console:
>
> ...
> atmel_ac97c atmel_ac97c.0: channel A event
> atmel_ac97c atmel_ac97c.0: channel A event
> atmel_ac97c atmel_ac97c.0: channel A event
> ...
>
> If I see it right these, lines come from sound/atmel/ac97c.c->atmel_ac97c_interrupt():
>
> dev_info(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
>                                  casr&  AC97C_CSR_OVRUN   ? " OVRUN"   : "",
>                                  casr&  AC97C_CSR_RXRDY   ? " RXRDY"   : "",
>                                  casr&  AC97C_CSR_UNRUN   ? " UNRUN"   : "",
>                                  casr&  AC97C_CSR_TXEMPTY ? " TXEMPTY" : "",
>                                  casr&  AC97C_CSR_TXRDY   ? " TXRDY"   : "",
>                                  !casr                    ? " NONE"    : "");
>
>
>
> It is necessary to output this message in normal mode or is it a debug message?
>
> Regards,
> Yegor
>
