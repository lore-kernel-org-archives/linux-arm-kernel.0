From: fg@emlix.com (Fabian Godehardt)
Date: Mon, 8 Feb 2010 14:13:19 +0100
Subject: atmel-mci / at91_mci
In-Reply-To: <4B6A8C0F.7080907@iis.fraunhofer.de>
References: <4B6A8C0F.7080907@iis.fraunhofer.de>
Message-ID: <201002081413.19984.fg@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Donnerstag 04 Februar 2010 09:57:51 schrieb Manuel Stahl:
> Hi all,
> 
> I have a question regarding the atmel-mci/at91_mci driver merge.
> Actually I have an at91rm9200 device which get's an CRC error while
> inializing an SD-card. I guess it's because of an at91rm9200 errata:
> 
> - Data Endianess inversion from the MCI to MMC or SD Card
> 
> The at91_mci driver did some byte swapping in 'at91_mci_sg_to_dma'
>  function. Where would I implement this in the atmel-mci driver?
> 
> Attached is the kernel log when I insert a card.

Some time ago i had a 9200 with 2.6.20 where i had similar problems (AFAIR).

My workaround was to reduce the frequency on card initialization (somewhere on 
probe() ):

	mmc->f_min = 325000;

and deactivating 4WIRE mode.

Maybe this also helps in your case.


Mit freundlichen Gr??en/With kind regards

Fabian Godehardt

-- 
Besuchen Sie uns auf der Embedded World 2010 in N?rnberg!
-> Halle 11, Stand 222

Dipl.-Ing. (FH) Fabian Godehardt, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax -11, Bahnhofsallee 1b, 37081 G?ttingen, Germany
Sitz der Gesellschaft: G?ttingen, Amtsgericht G?ttingen HR B 3160
Gesch?ftsf?hrer: Dr. Uwe Kracke, Ust-IdNr.: DE 205 198 055

emlix - your embedded linux partner
