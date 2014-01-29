From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Jan 2014 10:57:32 -0600
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <52E92842.3000001@amd.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
 <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
Message-ID: <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 10:11 AM, Suravee Suthikulanit
<suravee.suthikulpanit@amd.com> wrote:
> On 1/17/2014 5:08 AM, Andreas Herrmann wrote:
>>
>>
>> arm-smmu driver uses of_parse_phandle_with_args when parsing DT
>> information to determine stream IDs for a master device.
>> Thus the number of stream IDs per master device is bound by
>> MAX_PHANDLE_ARGS.
>>
>> To support Calxeda ECX-2000 hardware arm-smmu driver requires a
>> slightly higher value for MAX_PHANDLE_ARGS as this hardware has 10
>> stream IDs for one master device.
>>
>> Increasing it to 16 seems a reasonable choice.
>>
>> Cc: Grant Likely <grant.likely@linaro.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: devicetree at vger.kernel.org
>> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
>> ---
>>   include/linux/of.h |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 276c546..24e1b28 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -67,7 +67,7 @@ struct device_node {
>>   #endif
>>   };
>>
>> -#define MAX_PHANDLE_ARGS 8
>> +#define MAX_PHANDLE_ARGS 16
>
>
> Since the MMU-500 specify "Number of SMRs" upto 128 registers, shouldn't
> this be changed to be able to support 128 StreamIDs as well?  Although I am
> not sure if this would be too big to have on the stack per Rob's comment in
> the previous patch set.

Do you actually need 128 now? If not, then we can deal with that when
we get there. There are lots of things in spec's that are not actually
implemented or supported.

Rob
