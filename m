From: eric@eukrea.com (=?ISO-8859-1?Q?Eric_B=E9nard?=)
Date: Wed, 23 Jun 2010 17:07:49 +0200
Subject: [PATCH] otg/ulpi.c : fix register write
In-Reply-To: <20100623145816.GE2698@buzzloop.caiaq.de>
References: <1277304632-11314-1-git-send-email-eric@eukrea.com>
	<20100623145816.GE2698@buzzloop.caiaq.de>
Message-ID: <4C222345.4000902@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/06/2010 16:58, Daniel Mack a ?crit :
> On Wed, Jun 23, 2010 at 04:50:32PM +0200, Eric B?nard wrote:
>> -static int ulpi_write(struct otg_transceiver *otg, u32 val, u32 reg)
>> +static int ulpi_write(struct otg_transceiver *otg, u32 reg, u32 val)
>
> Urgs. Is this really necessary? It's not that I have a strong opinion
> about the order of arguments in such cases (I kept to the convention
> of __readl() when I wrote it). But _changing_ it like this is really
> confusing. Once in awhile I stumble over such API changes and I always
> wonder about the reason. The problem is that not even the compiler will
> warn you if you got it wrong, when you copied a sniplet from older
> sources etc.
>
> And you really want to break someone knee caps once you find out what
> caused the breakage ;)
>
> So - if we can avoid that, we should do. If anyone speaks up with a real
> reason for changing it, I'd be fine :)
>
No problem if you prefer to keep as it is (this is "cosmetic" but val 
and reg are reversed in include/linux/usb/otg.h which I took as the 
reference in the present case).
Do you have any opinion on the other part of the patch which removes 
ULPI_SET as this prevents to clear bits in the phy register ? If ok for 
you, I send a revised patch containing only this change.

Thanks,
Eric
