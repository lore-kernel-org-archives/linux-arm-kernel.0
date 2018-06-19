From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 19 Jun 2018 03:28:19 +0200
Subject: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
In-Reply-To: <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <20180618114920.654647c0@bbrezillon>
 <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
 <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
Message-ID: <5b66cafe-782e-43a9-c221-cf0a1528f382@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2018 02:00 PM, Claudiu Beznea wrote:
> 
> 
> On 18.06.2018 12:53, Marek Vasut wrote:
>> On 06/18/2018 11:49 AM, Boris Brezillon wrote:
>>> Hi Claudiu,
>>>
>>> The subject prefix should be "mtd: spi-nor: atmel-quadspi: ". No need
>>> to send a new version just for that, I'll fix it when applying the
>>> patch.
>>>
> Hi Boris,
> 
> Thank you!
> 
>>> Looks good otherwise. Marek, any objection? If not, can you add your
>>> Acked-by?
>>
>> Will this work if you have ie. ubifs mounted on that QSPI NOR and you
>> suspect and resume during IO ? I think it would, but just curious if
>> there could be some problem.
> 
> Hi Marek,
> 
> I tested only with read/writes while suspending, simple scripts, but not
> having ubifs mounted on QSPI NOR. I will double check also with ubifs
> mounted on QSPI NOR and come back with the results.

Thanks. I think it's gonna be OK, but let's just be sure.
Make sure to disable 4K sector support when fiddling with UBI/UBIFS on
QSPI NOR.

-- 
Best regards,
Marek Vasut
