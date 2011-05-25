From: Hong.Xu@atmel.com (Xu, Hong)
Date: Wed, 25 May 2011 14:18:38 +0800
Subject: LCDVSYNC not set up in Atmel AT91SAM9RL device code
In-Reply-To: <4DDAC947.7040705@usask.ca>
References: <4DDAC947.7040705@usask.ca>
Message-ID: <4C79549CB6F772498162A641D92D532801C916AD@penmb01.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicholas,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org
> [mailto:linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of
> Nicholas Kinar
> Sent: Tuesday, May 24, 2011 4:53 AM
> To: linux-arm-kernel at lists.infradead.org
> Subject: LCDVSYNC not set up in Atmel AT91SAM9RL device code
> 
> Hello,
> 
> I've been setting up an LCD display interfaced to the Atmel AT91SAM9RL
> processor, and I noticed that in the
> /arch/arm/mach-at91/at91sam9rl_devices.c file, the GPIO pin AT91_PIN_PC4
> is not switched over to the LCD peripheral.
> 
> To make the LCD display peripheral operate properly, I had to add the
> following line to the at91_add_device_lcdc() function:
> 
> at91_set_A_periph(AT91_PIN_PC4, 0);    /* LCDVSYNC */

You're right. Although the LCD panel on Atmel's AT91SAM9RL-EK does not need the VSYNC, you board needs. I just sent out a small patch about this and put you in the "Reported-by" line. Thanks.

> Perhaps this could be patched?  I do not know if a similar issue also
> occurs in other device setup files.
AT91SAM9263-EK has the same issue as you specified, another patch will be sent out, thanks.

BR,
Eric
