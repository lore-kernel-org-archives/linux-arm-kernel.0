From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 07 Oct 2015 14:21:55 +0100
Subject: [PATCH v2 2/3] nvmem: core: set the size for the nvmem binary
 file.
In-Reply-To: <20151007125612.GB7962@kroah.com>
References: <1444215536-10783-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1444215655-10878-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20151007125612.GB7962@kroah.com>
Message-ID: <56151C73.90704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/10/15 13:56, Greg KH wrote:
> On Wed, Oct 07, 2015 at 12:00:55PM +0100, Srinivas Kandagatla wrote:
>> This patch sets the actual size of binary file to the nvmem size.
>> Previously this was not possible as the core was using the static global
>> data structures for attributes.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/nvmem/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index 0a70e31..737fa75 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -315,6 +315,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>   	if (!nvmem->read_only)
>>   		nvmem->bin.attr.mode |= S_IWUSR;
>>
>> +	nvmem->bin.size = nvmem->size;
>
> Why does the size matter?  What userspace tool needs to know this?
Yes, you are correct, sized should not matter as read would return EOF 
anyway.
I think I overdone this :-)

--srini
>
> thanks,
>
> greg k-h
>
