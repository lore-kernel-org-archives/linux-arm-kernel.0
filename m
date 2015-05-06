From: bintian.wang@huawei.com (Bintian)
Date: Wed, 6 May 2015 18:36:07 +0800
Subject: [PATCH v4 5/5] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150506093022.GB31001@leverpostej>
References: <1430827599-11560-1-git-send-email-bintian.wang@huawei.com>
 <1430827599-11560-6-git-send-email-bintian.wang@huawei.com>
 <20150505171349.GA30215@leverpostej> <5549877C.10408@huawei.com>
 <5549B9CC.1040709@huawei.com> <20150506093022.GB31001@leverpostej>
Message-ID: <5549EE97.3020801@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 2015/5/6 17:30, Mark Rutland wrote:
> On Wed, May 06, 2015 at 07:50:52AM +0100, Bintian wrote:
>> Hello Mark,
>>
>> On 2015/5/6 11:16, Bintian wrote:
>>> Hello Mark,
>>>
>>> On 2015/5/6 1:13, Mark Rutland wrote:
>> [...]
>>>>> +        uart0: uart at f8015000 {    /* console */
>>>>> +            compatible = "arm,pl011", "arm,primecell";
>>>>> +            reg = <0x0 0xf8015000 0x0 0x1000>;
>>>>> +            interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +            clocks = <&ao_ctrl HI6220_UART0_PCLK>, <&ao_ctrl
>>>>> HI6220_UART0_PCLK>;
>>>>> +            clock-names = "uartclk", "apb_pclk";
>>>>> +        };
>>>>
>>>> In a previous discussion [1] the UART on HI6220 was described as not
>>>> fully PL011 compliant, with a number of differences (e.g. the FIFO
>>>> length).
>>>>
>>>> Given that, I feel somewhat uncomfortable with the current compatible
>>>> string list. What exactly are those differences? We may need a more
>>>> specific compatible string (even if in addition to those existing ones),
>>>> or perhaps other properties.
>>> The small system can be booted and the console also works well without
>>> changing any code of driver amba-pl011.c, so I think the compatible
>>> string is OK for this patch set.
>>>
>>> Hisilicon do some performance enhancements based on PL011, but the
>>> current driver "amba-pl011.c" also works on hi6220 without those
>>> enhancements driver code.
>> Checked with Hisilicon chip designer, the UART0 is used for DEBUG
>> console and compliant with PL011 fully.
>
> I think that given that we know the UART is not quite a PL011 we should
> add an additional compatible string just in case some difference crops
> up later that is problematic.
>
> So we'd have something like:
>
> 	compatible = "hisilicon,hi6220-uart", "arm,pl011", "arm,primecell";
>
> That way we can add any optimisations or workarounds later as required.
I understand and thanks for your suggestion.

Can I do not do this work in this patch set? Because I got the
information UART0 is PL011 compatible. Hisilicon uart engineer can do
this work in the future, maybe for UART1/UART2.

Thank you Mark,

BR,

Bintian

>
> Thanks,
> Mark.
>
> .
>
