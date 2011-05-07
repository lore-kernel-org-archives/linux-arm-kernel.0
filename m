From: arend@broadcom.com (Arend van Spriel)
Date: Sat, 7 May 2011 19:04:01 +0200
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTi=GJs=04H=HpCDy_o1JnhY4+aPgxA@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304776555.16344.2.camel@maggie> <4DC57383.3050903@broadcom.com>
	<BANLkTi=GJs=04H=HpCDy_o1JnhY4+aPgxA@mail.gmail.com>
Message-ID: <4DC57B81.6030705@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2011 06:49 PM, Rafa? Mi?ecki wrote:
> 2011/5/7 Arend van Spriel<arend@broadcom.com>:
>> On 05/07/2011 03:55 PM, Michael B?sch wrote:
>>>> Arnd: did you have a look at defines at all?
>>>>
>>>> Most of the defines have values in range 0x800 ? 0x837. Converting
>>>> this to array means loosing 0x800 u16 entries. We can not use 0x800
>>>> offset, because there are also some defined between 0x000 and 0x800:
>>>> #define BCMA_CORE_OOB_ROUTER           0x367   /* Out of band */
>>>> #define BCMA_CORE_INVALID              0x700
>> Please be aware that the core identifier itself is not unique (in the
>> current list they are). In the scan the BCMA_CORE_OOB_ROUTER will always
>> show BCMA_MANUF_ARM (did not look up the proper manufacturer define but you
>> get the idea, i hope).
> Unfortunately, I don't. Could you explain this? How core identified
> can be not unique? Can 0x800 mean ChipCommon but also SuperPCIeX?
Yes, if ChipCommon is Broadcom core and SuperPCIeX is ARM core (or some 
other). The core identifiers are chosen by a chip manufacturer (eg. 
Broadcom ;-) ). They are not unique by itself so that is why the 
bcma_device_id consists of manufacturer, id, rev, and class. Providing a 
device table with ANY_MANUF would be a bad idea.

Gr. AvS
