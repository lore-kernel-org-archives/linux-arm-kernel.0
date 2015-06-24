From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 24 Jun 2015 10:56:11 +0100
Subject: [PATCH v6 1/9] nvmem: Add a simple NVMEM framework for nvmem
 providers
In-Reply-To: <7BE8C921-180A-411D-A3C0-5D2A7AE3AB6A@konsulko.com>
References: <1435014459-26138-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435014507-26181-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1435035173.9808.35.camel@perches.com>
 <7BE8C921-180A-411D-A3C0-5D2A7AE3AB6A@konsulko.com>
Message-ID: <558A7EBB.6000304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/06/15 10:26, Pantelis Antoniou wrote:
> Hi Joe,
>
>> >On Jun 23, 2015, at 05:52 , Joe Perches<joe@perches.com>  wrote:
>> >
>> >On Tue, 2015-06-23 at 00:08 +0100, Srinivas Kandagatla wrote:
>>> >>This patch adds just providers part of the framework just to enable easy
>>> >>review.
>> >[]
>>> >>include/linux/nvmem-provider.h |  54 ++++++
>> >
>> >Unless there are going to be users of nvmem-provider.h
>> >outside of the drivers/nvmem directory, perhaps that
>> >file (and nvmem-consumer.h) should be in drivers/nvmem/
>> >
>> >
> nvmem-consumer.h should be accessible from any driver, no?
>
> And unfortunately nvmem-provider should be accessible too.
> There are already eeprom drivers in the eeprom/misc directory that
> cannot be moved yet to drivers/nvmem (like at24).
>
> They need the provider definitions while they provide both the old
> style interface, and the new NVMEM based one.
>
> When we move them to the drivers/nvmem directory, then yes the
> provider header file should move there.

Yep, that's the plan.

---srini
>
> Regards
>
> ? Pantelis
>
