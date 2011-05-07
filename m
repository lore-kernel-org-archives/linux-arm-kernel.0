From: arend@broadcom.com (Arend van Spriel)
Date: Sat, 7 May 2011 18:29:55 +0200
Subject: [PATCH][WAS:bcmai,axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <1304776555.16344.2.camel@maggie>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<201105061605.31625.arnd@arndb.de>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<1304776555.16344.2.camel@maggie>
Message-ID: <4DC57383.3050903@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2011 03:55 PM, Michael B?sch wrote:
>
>> Arnd: did you have a look at defines at all?
>>
>> Most of the defines have values in range 0x800 ? 0x837. Converting
>> this to array means loosing 0x800 u16 entries. We can not use 0x800
>> offset, because there are also some defined between 0x000 and 0x800:
>> #define BCMA_CORE_OOB_ROUTER           0x367   /* Out of band */
>> #define BCMA_CORE_INVALID              0x700
Please be aware that the core identifier itself is not unique (in the 
current list they are). In the scan the BCMA_CORE_OOB_ROUTER will always 
show BCMA_MANUF_ARM (did not look up the proper manufacturer define but 
you get the idea, i hope).

Gr. AvS
