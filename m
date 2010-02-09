From: manuel.stahl@iis.fraunhofer.de (Manuel Stahl)
Date: Tue, 09 Feb 2010 16:49:50 +0100
Subject: atmel-mci / at91_mci
In-Reply-To: <201002081413.19984.fg@emlix.com>
References: <4B6A8C0F.7080907@iis.fraunhofer.de>
	<201002081413.19984.fg@emlix.com>
Message-ID: <4B71841E.7030108@iis.fraunhofer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.02.2010 14:13, schrieb Fabian Godehardt:
> Hi,
>
> Am Donnerstag 04 Februar 2010 09:57:51 schrieb Manuel Stahl:
>> Hi all,
>>
>> I have a question regarding the atmel-mci/at91_mci driver merge.
>> Actually I have an at91rm9200 device which get's an CRC error while
>> inializing an SD-card. I guess it's because of an at91rm9200 errata:
>>
>> - Data Endianess inversion from the MCI to MMC or SD Card
>>
>> The at91_mci driver did some byte swapping in 'at91_mci_sg_to_dma'
>>   function. Where would I implement this in the atmel-mci driver?
>>
>> Attached is the kernel log when I insert a card.
>
> Some time ago i had a 9200 with 2.6.20 where i had similar problems (AFAIR).
>
> My workaround was to reduce the frequency on card initialization (somewhere on
> probe() ):
>
> 	mmc->f_min = 325000;
>
> and deactivating 4WIRE mode.
>
> Maybe this also helps in your case.

Unfortunately this is not the problem. The SD-card works fine with the 
old at91_mci driver, but not with the newer atmel-mci. The problem is 
that I need both slots at the same time, so at91_mci is no option for me.

In the second slot there is a WLAN card which gets timeouts after 
successful firmware load with at91_mci but does not work with atmel-mci.

I have exactly the same setup with an AVR32 processor, there both 
devices work. With the atmel-mci driver obiously.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100209/389bfd88/attachment-0001.p7s>
