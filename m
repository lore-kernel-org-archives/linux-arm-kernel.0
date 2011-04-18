From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Mon, 18 Apr 2011 16:31:02 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <201104181619.35115.arnd@arndb.de>
References: <BANLkTim7Uj2tsgFngWhUqFK_hk3Leg+sQA@mail.gmail.com>
	<201104171938.12834.arnd@arndb.de>
	<BANLkTim6iCAsViJQS4XrY-XObs8pp-BiQQ@mail.gmail.com>
	<201104181619.35115.arnd@arndb.de>
Message-ID: <BANLkTinB-9h=bZg9zg219i2wi3zUCA6mcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 18 kwietnia 2011 16:19 u?ytkownik Arnd Bergmann <arnd@arndb.de> napisa?:
> On Monday 18 April 2011, Rafa? Mi?ecki wrote:
>> W dniu 17 kwietnia 2011 19:38 u?ytkownik Arnd Bergmann <arnd@arndb.de> napisa?:
>>
>> > In general, the bus_type directly relates to how a device gets probed.
>> > If broadcom uses the same basic register layout as regular AMBA devices,
>> > it should use the amba bus type.
>>
>> From Broadcom side we *could* use some registers that are AMBA
>> specific, they are present... but there is totally no point in doing
>> that. Everything we use is Broadcom specific.
>>
>>
>> > I think it would be fine to extend the AMBA bus slightly if there are
>> > just minor differences.
>>
>> As I said, Broadcom specific driver use nothing from AMBA common
>> things. Plus we implement routines that are Broadcom specific and no
>> other platform will use them.
>
> You mean the hardware has two sets of registers containing the same
> information, one of them the standard registers, and one with broadcom
> specific ones?
>
> Why don't you just use the standard ones then?

No. Did you read my first mail in this thread?

There is pair of cores for every device. First is AMBA-specific called
agent/wrapper and second one is Broadcom-specific.

AMBA specific core called agent/wrapper has AMBA specific registers:
CID and PID. However we do not ever read that in Broadcom driver,
because that are useless for us. On AMBA specific core we use only
some Broadcom specific registers to manage (enable/disable) *second*
(Broadcom-specific) core.

-- 
Rafa?
