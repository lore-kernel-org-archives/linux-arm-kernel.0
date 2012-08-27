From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Mon, 27 Aug 2012 16:00:14 +0200
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>,
 <503B4919.6080306@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECC330@EXMDB06.org.aalto.fi>,
 <503B623C.4030304@atmel.com>
 <BC0F374A1C27184AB96177CDFEC2F54225ECD36E@EXMDB06.org.aalto.fi>
 <EF2E73589CA71846A15D0B2CDF79505D090EC3D6F6@wm021.weinmann.com>
Message-ID: <503B7D6E.7090906@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/27/2012 03:32 PM, Voss, Nikolaus a ?crit :
> Hi Adian,
>
> Yanes Martinez Adrian wrote on Monday, August 27, 2012 2:46 PM:
>> Le 08/27/2012 12:40 PM, Yanes Martinez Adrian a ?crit :
>>> Hi Ludovic,
>>>
>>>> Tested on at91rm9200, at91sam9261, at91sam9g20 and at91sam9m10 with
>>>> eeprom, temperature sensor and rtc devices (and wolfson chip for
>>>> sam9g20).
>>>
>>> concerning the at91rm9200, what was the amount of bytes you
>> transmitted?
>>>
>>
>>> I have only checked that I can communicate with i2c devices so the
>>> amount is very low (1-4 bytes).
>>
>> IIRC it was from >7 bytes when the issues appeared.
>>
>>> Some months ago I performed some testing[1] with the previous version of
>>> the patch and the main conclusion was that the absence of PDC in the
>>> AT91RM9200 made this driver unusable in such platform.
>
> I didn't get your last post  in that thread. In my opinion RM9200 should really
> be excluded from being configured with this driver, what's your opinion
> Ludovic?

Yes, the use of the TWI controller may be removed for some chips since 
there are issues that are dependent on the controller itself. RM9200 is 
not the only one.

For the moment, I don't have the necessary knowledge about the TWI 
controller to take a decision. I would say it can be done in an other 
patch in order to have your driver included in the mainline quickly 
since it doesn't introduce a breakage.

Regards

Ludovic

>
> Regards,
> Niko
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
