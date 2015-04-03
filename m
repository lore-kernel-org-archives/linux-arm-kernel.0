From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 3 Apr 2015 10:35:56 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Get current parent clock for power
 domain on/off
In-Reply-To: <551E4B85.1000903@samsung.com>
References: <1427961979-29477-1-git-send-email-k.kozlowski@samsung.com>
 <551D362B.90901@collabora.co.uk>
 <CAJKOXPc1dfHAaUQd+3HDhNwQW8xYDeoYFgN6QMkmQPEnLGtG-A@mail.gmail.com>
 <551E4B85.1000903@samsung.com>
Message-ID: <CAJKOXPcqSk3oaqdsW3LLzQCmL09+pZa5qb9tSBMiJMq_ZLSByQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-03 10:12 GMT+02:00 Andrzej Hajda <a.hajda@samsung.com>:
> On 04/02/2015 02:44 PM, Krzysztof Kozlowski wrote:
>> 2015-04-02 14:29 GMT+02:00 Javier Martinez Canillas
>> <javier.martinez@collabora.co.uk>:
>>> Hello Krzysztof,
>>>
>>> On 04/02/2015 10:06 AM, Krzysztof Kozlowski wrote:
>>>> Using a fixed (by DTS) parent for clocks when turning on the power domain
>>>> may introduce issues in other drivers. For example when such driver
>>>> changes the parent during runtime and expects that he is the only place
>>>> of such change.
>>>>
>>>> Do not rely entirely on DTS providing the fixed parent for such clocks.
>>>> Instead if "pclkN" clock name is missing, grab a current parent of clock
>>>> with clk_get_parent().
>
> Hi Krzysztof,
>
> I wonder if it wouldn't be better to drop entirely pclks. Power domains
> should save/restore its previous state, setting fixed parents on domain
> resume can fool drivers as you described earlier.

I wanted to preserve full backward compatibility (including behaviour
compatibility). However I can't find valid reason to switch to some
fixed clock after powering up domain so if there are not objections I
will drop pclk entirely.

Thanks!
Krzysztof
