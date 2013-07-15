From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Jul 2013 17:06:38 -0600
Subject: [PATCH V2 3/5] of: introduce of_parse_phandle_with_fixed_args
In-Reply-To: <51E44688.3050805@cogentembedded.com>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
 <1373913629-32179-3-git-send-email-swarren@wwwdotorg.org>
 <51E44688.3050805@cogentembedded.com>
Message-ID: <51E4807E.3090505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 12:59 PM, Sergei Shtylyov wrote:
> On 07/15/2013 10:40 PM, Stephen Warren wrote:
> 
>> From: Stephen Warren <swarren@nvidia.com>
> 
>> This is identical to of_parse_phandle_with_args(), except that the
>> number of argument cells is fixed, rather than being parsed out of the
>> node referenced by each phandle.

>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 23e7073..ad799d9 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1106,7 +1106,8 @@ EXPORT_SYMBOL(of_parse_phandle);
>>
>>   static int __of_parse_phandle_with_args(const struct device_node *np,
>>                       const char *list_name,
>> -                    const char *cells_name, int index,
>> +                    const char *cells_name,
>> +                    int cells_count, int index,
> 
>    The correct grammar would be 'cell_name' and 'cell_count' I think.

I guess I can see the argument for cell_count, but "cells_name" is named
based on the DT property named "gpio-cells", so "cells" seems correct
here (and is a pre-existing issue anyway).

I'll fix up cell_count and the brace issue locally, but hold off reposting.
