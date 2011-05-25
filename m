From: n.kinar@usask.ca (Nicholas Kinar)
Date: Wed, 25 May 2011 11:03:37 -0600
Subject: LCDVSYNC not set up in Atmel AT91SAM9RL device code
In-Reply-To: <4C79549CB6F772498162A641D92D532801C916AD@penmb01.corp.atmel.com>
References: <4DDAC947.7040705@usask.ca>
	<4C79549CB6F772498162A641D92D532801C916AD@penmb01.corp.atmel.com>
Message-ID: <4DDD3669.2060505@usask.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/2011 12:18 AM, Xu, Hong wrote:
> Hi Nicholas,
>> -----Original Message-----
>> From: linux-arm-kernel-bounces at lists.infradead.org
>> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
>> Nicholas Kinar
>> Sent: Tuesday, May 24, 2011 4:53 AM
>> To: linux-arm-kernel at lists.infradead.org
>> Subject: LCDVSYNC not set up in Atmel AT91SAM9RL device code
>>
>> Hello,
>>
>> I've been setting up an LCD display interfaced to the Atmel AT91SAM9RL
>> processor, and I noticed that in the
>> /arch/arm/mach-at91/at91sam9rl_devices.c file, the GPIO pin AT91_PIN_PC4
>> is not switched over to the LCD peripheral.
>>
>> To make the LCD display peripheral operate properly, I had to add the
>> following line to the at91_add_device_lcdc() function:
>>
>> at91_set_A_periph(AT91_PIN_PC4, 0);    /* LCDVSYNC */
> You're right. Although the LCD panel on Atmel's AT91SAM9RL-EK does not need the VSYNC, you board needs. I just sent out a small patch about this and put you in the "Reported-by" line. Thanks.
>
>> Perhaps this could be patched?  I do not know if a similar issue also
>> occurs in other device setup files.
> AT91SAM9263-EK has the same issue as you specified, another patch will be sent out, thanks.
>
> BR,
> Eric
>
Thank you; this is very useful.

Nicholas
