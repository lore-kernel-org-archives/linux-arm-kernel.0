From: manuel.stahl@iis.fraunhofer.de (Manuel Stahl)
Date: Thu, 04 Feb 2010 09:57:51 +0100
Subject: atmel-mci / at91_mci
Message-ID: <4B6A8C0F.7080907@iis.fraunhofer.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a question regarding the atmel-mci/at91_mci driver merge. 
Actually I have an at91rm9200 device which get's an CRC error while 
inializing an SD-card. I guess it's because of an at91rm9200 errata:

- Data Endianess inversion from the MCI to MMC or SD Card

The at91_mci driver did some byte swapping in 'at91_mci_sg_to_dma' function.
Where would I implement this in the atmel-mci driver?

Attached is the kernel log when I insert a card.

Regards,
-- 

Dipl.-Inf. Manuel Stahl
Fraunhofer-Institut f?r Integrierte Schaltungen IIS
- Leistungsoptimierte Systeme -
Nordostpark 93                Telefon  +49 (0)911/58061-6419
90411 N?rnberg                Fax      +49 (0)911/58061-6398
http://www.iis.fraunhofer.de  manuel.stahl at iis.fraunhofer.de


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: atmel-mci.log
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100204/7dd51cd3/attachment-0001.el>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 6148 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100204/7dd51cd3/attachment-0001.p7s>
