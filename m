From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 9 Oct 2011 15:28:18 +0800
Subject: [PATCH 17/26] ARM: pxa: pxa95x is incompatible with earlier pxa
In-Reply-To: <CAN1soZzbtqxfNLS_JVhn1irXRVThL=yt_VWfmdkoUL2ShFDEGQ@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<CAMPhdO_L-g4vSj3fC-1ckqnHGAPhWOy6Hm4VL5iUbZbbdjRkNQ@mail.gmail.com>
	<CAN1soZy3_9Trycti8SCbnO75N6NE31tFqrKMpZtiJPgwNc2cbg@mail.gmail.com>
	<1499585.ED4ktnBDpX@wuerfel>
	<CAN1soZyDu43EN3W5YBttdzx7qx=MLKAR1OsJC3hUdqWWxhQaew@mail.gmail.com>
	<CAMPhdO8_cZU8FEGsK0m_XrhbR33TiZFFaNrXddKT1YrHREt-TQ@mail.gmail.com>
	<CAN1soZzbtqxfNLS_JVhn1irXRVThL=yt_VWfmdkoUL2ShFDEGQ@mail.gmail.com>
Message-ID: <CAMPhdO-b2hiXUNSKLqio4uHOEby=H82ckC0oahzRToatXmzw_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> They are actually not mutually exclusive - it's a trick we use to select
>> MACH_TAVOREVB3 by default but this option also disappears once SAARB
>> is selected.
>>
> OK. Could I know why saarb should be deselected while tavorevb3 is selected?

Haojian, it's not being deselected, it's just when user selects SAARB,
this config PXA_V7_MACH_AUTO becomes invalid (which means at
least one PXA_V7_MACH is selected), and then you could select
TAVOREVB3 as well.

Just go ahead and apply the patch, make menuconfig and see how
the trick works :-)
