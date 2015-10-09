From: petr.cvek@tul.cz (Petr Cvek)
Date: Fri, 9 Oct 2015 04:33:46 +0200
Subject: [PATCH v4 12/26] ARM: pxa: magician: Rename charger cable
 detection EGPIOs
In-Reply-To: <1443875934.4186.27.camel@gmail.com>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B1F8.8070104@tul.cz>
 <1443875934.4186.27.camel@gmail.com>
Message-ID: <5617278A.5060909@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 3.10.2015 v 14:38 Philipp Zabel napsal(a):
> Am Montag, den 28.09.2015, 23:32 +0200 schrieb Petr Cvek:
>> This patch renames EGPIOs, which are used for the charging cable
>> presence
>> and type detection. Old names did not correspond with an observed
>> functionality (on board_id 0x3a). The behavior is not:
>>
>> - AC charger
>> - USB charger
>> - Cable detection
>>
>> , but:
>>
>> - AC/USB type
>> - Cable detection1
>> - Cable detection2
>>
>> This patch fixes a possible typo in the bit offset for the cable
>> detection
>> EGPIO declaration, too.
>>
>> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
> 
> Just to be sure, please tell me what are the values of those three
> EGPIOs while
>   a) wall plug charger plugged in
>   b) usb cable connected to a host plugged in
>   c) no cable plugged in

usb	charger	none
====	=======	====
0xC0	0xC0	0xC0
0xA0	0xA0	0xA0
0x61	0x61	0x61
0x00	0x00	0x00
0x02	0x03	0x00	//first cable detection and charger type
0x3A	0x3A	0x3A	//send me your board_id
0x09	0x09	0x01	//second cable detection
0x04	0x04	0x04
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00
0x00	0x00	0x00

I think the charger is original.

> 
> It could well be there are differences between our boards.

Well it is CPLD chip, so they can have different bitstreams (OT: I can think of many CPLD HDL enhancements :-D).

Cheers,
Petr
