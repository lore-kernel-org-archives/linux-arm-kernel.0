From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 7 Mar 2016 11:30:30 -0300
Subject: [PATCH 0/2] [media] exynos4-is: Trivial fixes for DT
 port/endpoint parse logic
In-Reply-To: <56DD48C1.8010004@samsung.com>
References: <1457122813-12791-1-git-send-email-javier@osg.samsung.com>
 <CAJKOXPfOpqU2fGsNNaB6n_iuq2r-8z3TCSsqkncPbvkK2344Tg@mail.gmail.com>
 <56DD48C1.8010004@samsung.com>
Message-ID: <56DD9086.7070903@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sylwester,

On 03/07/2016 06:24 AM, Sylwester Nawrocki wrote:
> Hi Javier, Krzysztof,
> 
> On 03/05/2016 05:35 AM, Krzysztof Kozlowski wrote:
>> 2016-03-05 5:20 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>>> Hello,
>>>>
>>>> This series have two trivial fixes for issues that I noticed while
>>>> reading as a reference the driver's functions that parse the graph
>>>> port and endpoints nodes.
>>>>
>>>> It was only compile tested because I don't have access to a Exynos4
>>>> hardware to test the DT parsing, but the patches are very simple.
>>
>> Not directly related, but similar: my previous two patches for missing
>> of_node_put [0] are unfortunately still waiting. Although I have
>> Exynos4 boards, but I don't have infrastructure/scripts to test it.
>>
>> Best regards,
>> Krzysztof
>>

I've reviewed Krzysztof and looks good to me.

>> [0] https://patchwork.linuxtv.org/patch/32707/
> 
> Thanks for the patches, I've delegated them to myself and I'm going to
> review/apply them this week.
>

Thanks, I just noticed another similar issue in the driver now and is
that fimc_is_parse_sensor_config() uses the same struct device_node *
for looking up the I2C sensor, port and endpoint and thus not doing a
of_node_put() for all the nodes on the error path.

I think the right fix is to have a separate struct device_node * for
each so their reference counter cand be incremented and decremented.

> --
> Regards,
> Sylwester
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
