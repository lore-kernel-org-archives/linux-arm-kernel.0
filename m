From: heutling@who-ing.de (Sebastian Heutling)
Date: Mon, 15 Feb 2010 17:16:09 +0100
Subject: atmel-mci / at91_mci
In-Reply-To: <4B71841E.7030108@iis.fraunhofer.de>
References: <4B6A8C0F.7080907@iis.fraunhofer.de>	<201002081413.19984.fg@emlix.com>
	<4B71841E.7030108@iis.fraunhofer.de>
Message-ID: <4B797349.4030902@who-ing.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/10 16:49, Manuel Stahl wrote:
> Unfortunately this is not the problem. The SD-card works fine with the
> old at91_mci driver, but not with the newer atmel-mci. The problem is
> that I need both slots at the same time, so at91_mci is no option for me.
>
> In the second slot there is a WLAN card which gets timeouts after
> successful firmware load with at91_mci but does not work with atmel-mci.
>
> I have exactly the same setup with an AVR32 processor, there both
> devices work. With the atmel-mci driver obiously.
>    

Could that be related to the "SLOT_B" bit in the SDCR?
I had to set it in U-Boot to get the second slot working properly.
My guess is that on AT91 (we use SAM9G20) every access needs to set or 
clear that bit depending on which slot is addressed.

Sebastian Heutling
