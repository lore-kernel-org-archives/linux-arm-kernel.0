From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 27 Jun 2010 10:42:01 +0300
Subject: [PATCH v2] otg/ulpi.c : fix register write
In-Reply-To: <4C236D9A.4030707@eukrea.com>
References: <1277311435-12027-1-git-send-email-eric@eukrea.com>
	<4C236600.2030605@compulab.co.il> <4C236D9A.4030707@eukrea.com>
Message-ID: <4C2700C9.2090602@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/24/10 17:37, Eric B?nard wrote:
> Le 24/06/2010 16:04, Igor Grinberg a ?crit :
>> ulpi_set_flags is used to set the OTG flags and not to clear them,
>> also it is a static function and is not a part of struct
>> otg_transceiver,
>> so it cannot be called from outside the ulpi.c, thus after the
>> ulpi_create,
>> it is never called.
>> I think, currently, this should stay as it is.
>>
> OK, the problem that when one flag is set, you can't clear it without
> resetting the PHY.

This is correct, but current ulpi driver is not designed for writing
multiple times
into the ULPI_OTG_CTRL register, only once when ulpi_init function is
called.
Do you call the ulpi_init function for a couple of times? Looks like a hack.

>
> Eric
>

-- 
Regards,
Igor.
