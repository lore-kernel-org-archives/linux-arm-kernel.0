From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 8 Aug 2018 18:26:27 +0200
Subject: [PATCH 06/28] mtd: Add support for reading MTD devices via the
 nvmem API
In-Reply-To: <20180808162042.GG7275@lunn.ch>
References: <20180808153150.23444-1-brgl@bgdev.pl>
 <20180808153150.23444-7-brgl@bgdev.pl>
 <20180808162042.GG7275@lunn.ch>
Message-ID: <CAMpxmJXpx69oOjVccTLiDLus+gCXtMegc329udX99s1rZ2VJFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-08-08 18:20 GMT+02:00 Andrew Lunn <andrew@lunn.ch>:
> On Wed, Aug 08, 2018 at 05:31:28PM +0200, Bartosz Golaszewski wrote:
>> From: Alban Bedel <albeu@free.fr>
>>
>> Allow drivers that use the nvmem API to read data stored on MTD devices.
>> For this the mtd devices are registered as read-only NVMEM providers.
>> On OF systems only devices that have the 'nvmem-provider' property
>> are registered, on non-OF system all MTD devices are registered.
>> @@ -570,6 +613,11 @@ int add_mtd_device(struct mtd_info *mtd)
>>       if (error)
>>               goto fail_added;
>>
>> +     /* Add the nvmem provider */
>> +     error = mtd_nvmem_add(mtd);
>> +     if (error)
>> +             goto fail_nvmem_add;
>> +
>
> Hi Bartosz
>
> Maybe it is hiding somewhere, but i don't see any code looking into
> device tree looking for the 'nvmem-provider' property.
>
>        Andrew

Ugh, I copied the commit message from Alban's patch. For the moment
there's no such thing, you're right. I'll fix it for v2.

Bart
