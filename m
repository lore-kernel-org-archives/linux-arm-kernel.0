From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Wed, 21 Nov 2012 11:53:06 +0100
Subject: [PATCH v5 1/8] dt: add helper inline for retrieving timeout-sec
 property
In-Reply-To: <50ABB93F.5070109@gmail.com>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-2-git-send-email-fabio.porcedda@gmail.com>
 <50ABB93F.5070109@gmail.com>
Message-ID: <CAHkwnC98qT8k5TaW8Sw2F1KbwfoHhq7J-8_oJjpWp7h3rzs7Aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 6:09 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 11/19/2012 08:10 AM, Fabio Porcedda wrote:
>> The first user of this function is the watchdog framework.
>
> I still have issues with this. In addition to questionable usefulness
> outside the watchdog framework, I'm not even sure this is right for
> watchdog framework. Watchdog timeout is not a description of h/w, but
> user configuration. I think the existing mechanisms of module param or
> kernel cmdline is the right way to handle this.

Hi Rob,
thanks for the review.

If it's fine I will send a v6 version without the of_get_timeout_sec function,
I hope it's fine for Jean-Christophe too, he asked me to add that function.

About the right way to handle this parameter,
obviously I was thinking that was a good idea to add this binding,
Even some maintainers have suggested that was a good idea.

Regards

>
> Rob
>
>> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  include/linux/of.h | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/include/linux/of.h b/include/linux/of.h
>> index b4e50d5..d60fde9 100644
>> --- a/include/linux/of.h
>> +++ b/include/linux/of.h
>> @@ -477,4 +477,15 @@ static inline int of_property_read_u32(const struct device_node *np,
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
Software Developer - R&D Cagliari
Telit Communications S.p.A.
