From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 05 Oct 2010 17:42:51 +0200
Subject: [PATCH] ulpi: add i.MX25 & 35 internal PHY ID
In-Reply-To: <4CAB4047.1090401@eukrea.com>
References: <1286195012-18999-1-git-send-email-eric@eukrea.com>
	<4CA9EAA0.2060608@ru.mvista.com> <4CA9EF97.5040908@compulab.co.il>
	<20101005054225.GK7159@buzzloop.caiaq.de>
	<4CAB2145.8050605@compulab.co.il> <4CAB4047.1090401@eukrea.com>
Message-ID: <4CAB477B.5010003@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

On 10/05/10 17:12, Eric B?nard wrote:
> Hi Igor,
>
> Le 05/10/2010 14:59, Igor Grinberg a ?crit :
>> This driver is still in development stage and is not fully functional,
>> so I'd like to keep the table and ID info printing, but I really don't like
>> trivial IDs, like that of Eric.
>>
>> How about something like the attached patch?
>>
>> Eric, can you test if it works for you?
>>
>> If it's good, I can send a prettier version of it for review and merging.
>>
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
> ULPI transceiver vendor/product ID 0x0000/0x0000
> ULPI integrity check: failed!

Ah! It works ;)

>
> In fact, that's my fault, the internal PHY is not ULPI but UTMI so we should not use these functions here and it was working until now by chance as there are dedicated registers to control the internal PHY which are initialized with the right values as a default.

Too bad... I hope, I was useful in your discovery...

>
> Sorry for the noise and forget my patch which is wrong, I'll rework the platform data as in the present case we should not provide use ulpi when using the internal PHY.

OK.
Nevertheless, I want to resend a version of my patch properly.
It proves useful after all...
Any comments/suggestions will be appreciated.

-- 
Regards,
Igor.
