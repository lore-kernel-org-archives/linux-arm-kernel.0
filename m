From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 07:47:57 +0900
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <3874492.Rok1zBObEC@phil>
References: <2104342.rkElQpXtvM@phil> <1428172.jtv2HGWM9N@phil>
 <536D60B1.2070906@gmail.com> <3874492.Rok1zBObEC@phil>
Message-ID: <53714F9D.3010109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/14 08:33, Heiko St?bner wrote:
> Hi Tomasz,

>>>>> It seems this one just hit linux-next (in next-20140509).
>>>>
>>>> Which is bad, because:
>>>> a) it conflicts with patches already applied in samsung-clk tree,
>>>
>>> I remember seeing patches regarding more than one clk-samsung clock
>>> providers. Do you need any additional changes for s3c24xx from me for
>>> this?
>>
>> Yes, that's the problem here. If you could do it, I would appreciate it,
>> but if you don't have time then I can handle this. The changes needed
>> are mostly trivial - basically every common samsung_clk function gets
>> new argument to a context structure. The branch to base on would be
>> for_3.16/exynos5260 in samsung-clk tree.
>>

I think, would be better if we could fix the conflicts with Hekio's 
additional patches...basically nobody wants revert something for next 
tree once it is landed. But in this case, it's up to Tomasz...

Probably, Heiko resubmitted? Is it based on the branch Tomasz memtioned, 
I didn't check it yet?..

Tomasz, do you still want me to drop this series in samsung tree now? 
Additional patches would be helpful to me because other dependency i.e., 
exynos5260...for me.

>>>> b) the DT binding added by patch 4/9 has not been acked .
>>>
>>> I'm not 100% sure if this is necessary, as the binding is similar to most
>>> other Samsung bindings and looking through recent clock binding changes I
>>> didn't find any that seemed to have a special dt-maintainer ack -
>>> including
>>> Exynos ones. Also if I remember correctly there was this "if we don't
>>> respond, carry on" policy around :-) .
>>
>> Well, for me this could go as is, but rules should be followed and the
>> rules are ACK or 3 weeks and a ping without response. So we need to wait
>> at least to next Wednesday to bypass DT review.
>
> so I only remembered the abbreviated version of this :-) [without the 3 weeks
> requirement]. My guess is I should be able to adapt it to this change and also
> fix the typo Paul found until then.
>
In my memory, not 3 weeks...maybe 1week or 10days?...

- Kukjin
