From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 30 Mar 2015 18:08:40 +0200
Subject: [RFC PATCH v3 1/2] clk: samsung: Add a clock lookup function
In-Reply-To: <CA+Ln22Fn+TRGcFXH7m=LkOCpAtbdKq98jNNNDM0shYWvfHEBiA@mail.gmail.com>
References: <1427730803-28635-1-git-send-email-javier.martinez@collabora.co.uk>	<1427730803-28635-2-git-send-email-javier.martinez@collabora.co.uk>
 <CA+Ln22Fn+TRGcFXH7m=LkOCpAtbdKq98jNNNDM0shYWvfHEBiA@mail.gmail.com>
Message-ID: <55197508.5030501@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Tomasz,

On 03/30/2015 06:02 PM, Tomasz Figa wrote:
> Hi Javier,
> 
> 2015-03-31 0:53 GMT+09:00 Javier Martinez Canillas
> <javier.martinez@collabora.co.uk>:
>> The Samsung helpers functions to register clocks, add the clock instance
>> returned by the common clock framework to a lookup table that is used by
>> OF to lookup the clocks.
>>
>> But this table could also be useful to clock drivers if they need to get
>> a clock instance since the helper functions don't return them.
>>
>> The common clock framework __clk_lookup() function from the clk provider
>> API could be used by drivers as well. But it's more efficient to use the
>> Samsung specific lookup table that returns the clock instance in constant
>> time, than using the __clk_lookup() function that uses the clock name as
>> an index so it has a linear search time.
> 
> Is this really something we should be concerned about? If so, maybe
> the generic look-up function should be rewritten to use something
> faster, such as tree or hash table?
>

I don't performance is a big issue here. I just thought that since the
lookup table is already filled by the driver and the lookup function
is one line, we could use that instead to get the performance benefit.

But I don't mind to drop this patch and use the generic lookup function
from the CCF API if that is preferred.
 
> Best regards,
> Tomasz
>

Best regards,
Javier
