From: manuel.stahl@iis.fraunhofer.de (Manuel Stahl)
Date: Mon, 22 Feb 2010 10:56:47 +0100
Subject: atmel-mci / at91_mci
In-Reply-To: <4B797349.4030902@who-ing.de>
References: <4B6A8C0F.7080907@iis.fraunhofer.de>	<201002081413.19984.fg@emlix.com>
	<4B71841E.7030108@iis.fraunhofer.de> <4B797349.4030902@who-ing.de>
Message-ID: <4B8254DF.8090602@iis.fraunhofer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 15.02.2010 17:16, schrieb Sebastian Heutling:
> On 02/09/10 16:49, Manuel Stahl wrote:
>> Unfortunately this is not the problem. The SD-card works fine with the
>> old at91_mci driver, but not with the newer atmel-mci. The problem is
>> that I need both slots at the same time, so at91_mci is no option for me.
>>
>> In the second slot there is a WLAN card which gets timeouts after
>> successful firmware load with at91_mci but does not work with atmel-mci.
>>
>> I have exactly the same setup with an AVR32 processor, there both
>> devices work. With the atmel-mci driver obiously.
>
> Could that be related to the "SLOT_B" bit in the SDCR?
> I had to set it in U-Boot to get the second slot working properly.
> My guess is that on AT91 (we use SAM9G20) every access needs to set or
> clear that bit depending on which slot is addressed.

No there was a bug in the atmel_mci driver for 2.6.27 related to SDCR. 
With at91_mci you can only use one slot at a time, which is configured 
in the board setup code. The at91_mci driver communicates with the right 
slot, it can even download the firmware. Until then all SDIO traffic is 
OK, after the download there are timeouts. Maybe the restart of the 
device with the new firmware is not working properly.

Regards,
-- 
Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f?r Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N?rnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl at iis.fraunhofer.de


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 6148 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100222/1a8980b6/attachment.p7s>
