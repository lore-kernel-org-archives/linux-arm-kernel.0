From: bintian.wang@huawei.com (Bintian)
Date: Thu, 28 May 2015 16:17:23 +0800
Subject: [PATCH v8 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <20150528052608.22384.96747@quantum>
References: <1432440671-25235-1-git-send-email-bintian.wang@huawei.com>
 <1432440671-25235-3-git-send-email-bintian.wang@huawei.com>
 <20150528052608.22384.96747@quantum>
Message-ID: <5566CF13.8060806@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 2015/5/28 13:26, Michael Turquette wrote:
> Quoting Bintian Wang (2015-05-23 21:11:11)
>> Add clock drivers for hi6220 SoC, this driver controls the SoC
>> registers to supply different clocks to different IPs in the SoC.
>>
>> We add one divider clock for hi6220 because the divider in hi6220
>> also has a mask bit but it doesnot obey the rule defined by flag
>> "CLK_DIVIDER_HIWORD_MASK", we can not get index of the mask bit by
>> left shift fixed bits (e.g. 16 bits), so we add this divider clock
>> to handle it.
>>
>> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
>> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> Tested-by: Will Deacon <will.deacon@arm.com>
>> Tested-by: Tyler Baker <tyler.baker@linaro.org>
>
> Hi Bintian,
>
> Thanks for making the changes requested by Stephen. I've taken his patch
> to add assigned-clock-rate/parent support for AMBA interconnects and
> applied it to 4.1-rc1, and then I've applied your v8 patches #4-6 on top
> of that. You can find it at:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next-hi6220
Thank you very much!

I think you also need to pick patch "[PATCH v5 3/6] clk: hi6220: 
Document devicetree bindings for hi6220 clock",  which described the dt 
binding of clk, and it is also acked by Stephen(v4 is the same to v5).

> I have merged this into clk-next so it can get some cycles in
> linux-next.
>
> Stephen,
>
> Can you send your patch out to Russell properly? It needs his ack (or
> for him to take it outright) in order to unblock the hi6220 clock driver
> from being merged.
It doesn't block hi6220 clock driver now, because the UART1 is not
enabled in hi6220 dts now.

Thanks!

Bintian
>
> Regards,
> Mike
>
> .
>
