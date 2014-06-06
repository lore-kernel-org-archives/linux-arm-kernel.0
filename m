From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 06 Jun 2014 09:56:06 -0700
Subject: [PATCH v7 1/7] of: Provide function to request and map memory
In-Reply-To: <CAL_Jsq+KS8W6kZpCSpd68Oku7neFxPVLct1j=AYaXnyvOD3tGA@mail.gmail.com>
References: <1401989181-4712-1-git-send-email-matthias.bgg@gmail.com>	<1401989181-4712-2-git-send-email-matthias.bgg@gmail.com>
 <CAL_Jsq+KS8W6kZpCSpd68Oku7neFxPVLct1j=AYaXnyvOD3tGA@mail.gmail.com>
Message-ID: <5391F2A6.4040202@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2014 08:19 AM, Rob Herring wrote:
> On Thu, Jun 5, 2014 at 12:26 PM, Matthias Brugger
> <matthias.bgg@gmail.com> wrote:
>> A call to of_iomap does not request the memory region.
>> This patch adds the function of_io_request_and_map which requests
>> the memory region before mapping it.
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>> ---
>>  drivers/of/address.c       |   28 ++++++++++++++++++++++++++++
>>  include/linux/of_address.h |    8 ++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/drivers/of/address.c b/drivers/of/address.c
>> index cb4242a..c55b107 100644
>> --- a/drivers/of/address.c
>> +++ b/drivers/of/address.c
>> @@ -721,3 +721,31 @@ void __iomem *of_iomap(struct device_node *np, int index)
>>         return ioremap(res.start, resource_size(&res));
>>  }
>>  EXPORT_SYMBOL(of_iomap);
>> +
>> +/**
>> + * of_io_request_and_map - Requests a resource and maps the memory mapped IO
>> + *                        for a given device_node
> 
> I believe docbook requires this to be 1 line.

No longer so.  That was fixed a couple of years ago.


-- 
~Randy
