From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Thu, 11 Oct 2012 13:55:47 +0200
Subject: [PATCH v4 1/8] dt: add helper inline for retrieving timeout-sec
 property
In-Reply-To: <5075865C.3010606@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
 <1349784251-28261-2-git-send-email-fabio.porcedda@gmail.com>
 <5075865C.3010606@gmail.com>
Message-ID: <CAHkwnC9B7e-3bqar5ePmXQ9eNUnEAsnf+8mdjSKDshAHVQet6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 4:29 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 10/09/2012 07:04 AM, Fabio Porcedda wrote:
>> The first user of this function is the watchdog framework.
>
> Who is the 2nd user because I don't see any others. I don't see this
> being a widely used property.

Hi Rob, thanks for reviewing.

There is only one use of this function in my patchset.
I added this function after Jean-Christophe repeatedly suggested to add it.

On Fri, Oct 5, 2012 at 1:16 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> why I bother to comment
> *make this of generic* this is not watchdog specific other driver can use it

Maybe the idea was to have the helper ready when the dt support it's
added to a drivers that use a "timeout" parameter.

If it's for better i can just get rid of this function.
I don't mind.

Best regards

>
>>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  include/linux/of.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index 72843b7..5870818 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -470,4 +470,15 @@ static inline int of_property_read_u32(const struct device_node *np,
>>       return of_property_read_u32_array(np, propname, out_value, 1);
>>  }
>>
>> +/**
>> + * of_get_timeout_sec() - Helper to read the timeout_sec property
>> + * @np:              device node from which the property value is to be read.
>> + * @timeout: adress of the output value
>> + */
>> +static inline int of_get_timeout_sec(const struct device_node *np,
>> +                                  u32 *timeout)
>> +{
>> +     return of_property_read_u32(np, "timeout-sec", timeout);
>> +}
>> +
>>  #endif /* _LINUX_OF_H */
>>
>

-- 
Fabio Porcedda
