From: bintian.wang@huawei.com (Bintian)
Date: Fri, 29 May 2015 10:34:20 +0800
Subject: [PATCH v8 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150529010733.4469.33722@quantum>
References: <1432440671-25235-1-git-send-email-bintian.wang@huawei.com>
 <1432440671-25235-3-git-send-email-bintian.wang@huawei.com>
 <20150528052608.22384.96747@quantum> <5566CF13.8060806@huawei.com>
 <7h4mmwip62.fsf@deeprootsystems.com> <20150529010733.4469.33722@quantum>
Message-ID: <5567D02C.1070209@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 2015/5/29 9:07, Michael Turquette wrote:
> Quoting Kevin Hilman (2015-05-28 10:32:05)
>> Bintian <bintian.wang@huawei.com> writes:
>>
>>> Hello Mike,
>>>
>>> On 2015/5/28 13:26, Michael Turquette wrote:
>>>> Quoting Bintian Wang (2015-05-23 21:11:11)
>>>>> Add clock drivers for hi6220 SoC, this driver controls the SoC
>>>>> registers to supply different clocks to different IPs in the SoC.
>>>>>
>>>>> We add one divider clock for hi6220 because the divider in hi6220
>>>>> also has a mask bit but it doesnot obey the rule defined by flag
>>>>> "CLK_DIVIDER_HIWORD_MASK", we can not get index of the mask bit by
>>>>> left shift fixed bits (e.g. 16 bits), so we add this divider clock
>>>>> to handle it.
>>>>>
>>>>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>>>>> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
>>>>> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>>>> Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>>> Tested-by: Will Deacon <will.deacon@arm.com>
>>>>> Tested-by: Tyler Baker <tyler.baker@linaro.org>
>>>>
>>>> Hi Bintian,
>>>>
>>>> Thanks for making the changes requested by Stephen. I've taken his patch
>>>> to add assigned-clock-rate/parent support for AMBA interconnects and
>>>> applied it to 4.1-rc1, and then I've applied your v8 patches #4-6 on top
>>>> of that. You can find it at:
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next-hi6220
>>> Thank you very much!
>>>
>>> I think you also need to pick patch "[PATCH v5 3/6] clk: hi6220:
>>> Document devicetree bindings for hi6220 clock",  which described the
>>> dt binding of clk, and it is also acked by Stephen(v4 is the same to
>>> v5).
>>>
>>>> I have merged this into clk-next so it can get some cycles in
>>>> linux-next.
>>>>
>>>> Stephen,
>>>>
>>>> Can you send your patch out to Russell properly? It needs his ack (or
>>>> for him to take it outright) in order to unblock the hi6220 clock driver
>>>> from being merged.
>>> It doesn't block hi6220 clock driver now, because the UART1 is not
>>> enabled in hi6220 dts now.
>>
>> Now that the clk changes are queued up, can you (re)post the remaining
>> hikey patches with a changelog stating the dependency on the clk-next
>> branch.  I believe what's left is just the DT and Kconfig/defconfig
>> changes, correct?
>
> Just to be clear, clk-next-hi6220 is not an immutable branch. I just put
> it up to get some testing done on it. Depending on whether or not
> Russell acks Stephen's patch then it may be changed.
Stephen's patch can help UART1 to switch to the higher clock, so we can
remove the "clk_set_parent" from the "clk-hi6220.c" safely and don't
need to do that workaround in advance.

You know, we don't enable the UART1 in this series, and we can submit
other patch to enable it after Stephen's patch is merged.

Thanks,

Bintian

>
> Regards,
> Mike
>
>>
>> With some acks from the DT maintainers, these should be ready to be
>> merged through arm-soc.
>>
>> Thanks,
>>
>> Kevin
>
> .
>
