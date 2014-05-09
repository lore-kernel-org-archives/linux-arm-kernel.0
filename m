From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 10 May 2014 01:11:45 +0200
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <1428172.jtv2HGWM9N@phil>
References: <2104342.rkElQpXtvM@phil> <1399654181.19276.2.camel@x220>
 <536D1611.4010301@gmail.com> <1428172.jtv2HGWM9N@phil>
Message-ID: <536D60B1.2070906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 10.05.2014 01:07, Heiko St?bner wrote:
> Am Freitag, 9. Mai 2014, 19:53:21 schrieb Tomasz Figa:
>> On 09.05.2014 18:49, Paul Bolle wrote:
>>> On Wed, 2014-04-23 at 22:09 +0200, Heiko St?bner wrote:
>>>> Add platform device and select the correct implementation automatically
>>>> depending on wether the old samsung_clock or the common clock framework
>>>> is enabled.
>>>>
>>>> This is only done for machines already using the old dclk implementation,
>>>> as everybody else should move to use dt anyway.
>>>>
>>>> The machine-specific settings for the external clocks will have to be set
>>>> by somebody with knowledge about the specific hardware.
>>>>
>>>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>>
>>> It seems this one just hit linux-next (in next-20140509).
>>
>> Which is bad, because:
>> a) it conflicts with patches already applied in samsung-clk tree,
>
> I remember seeing patches regarding more than one clk-samsung clock providers.
> Do you need any additional changes for s3c24xx from me for this?
>

Yes, that's the problem here. If you could do it, I would appreciate it, 
but if you don't have time then I can handle this. The changes needed 
are mostly trivial - basically every common samsung_clk function gets 
new argument to a context structure. The branch to base on would be 
for_3.16/exynos5260 in samsung-clk tree.

>
>> b) the DT binding added by patch 4/9 has not been acked .
>
> I'm not 100% sure if this is necessary, as the binding is similar to most
> other Samsung bindings and looking through recent clock binding changes I
> didn't find any that seemed to have a special dt-maintainer ack - including
> Exynos ones. Also if I remember correctly there was this "if we don't respond,
> carry on" policy around :-) .
>

Well, for me this could go as is, but rules should be followed and the 
rules are ACK or 3 weeks and a ping without response. So we need to wait 
at least to next Wednesday to bypass DT review.

Best regards,
Tomasz
