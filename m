From: xuejiancheng@huawei.com (xuejiancheng)
Date: Wed, 13 Jan 2016 17:08:20 +0800
Subject: [PATCH v5 5/6] mfd: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <5675031.hi9rRCqFXs@wuerfel>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <20160112083946.GN19803@x1> <5694C725.6010502@huawei.com>
 <5675031.hi9rRCqFXs@wuerfel>
Message-ID: <56961404.1000602@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 2016/1/13 6:51, Arnd Bergmann wrote:
> On Tuesday 12 January 2016 17:28:05 xuejiancheng wrote:
>>>>>>>
>>>>>> Not yet.
>>>>>> Arnd Bergmann and Rob Herring all suggested adding a specific compatible string
>>>>>> with the SOC name. This binding is just used for describing the compatible string now.
>>>>>> When more functions on hi3519 SOC are added later, the specific driver will be also
>>>>>> needed.
>>>>>
>>>>> Save this binding until it has more functionality.  We here "I'll add
>>>>> to this later" all too often.
>>>>>
>>>>
>>>> In the hi3519.dtsi file, there is a system-controller device node described like below:
>>>> sysctrl: system-controller at 12010000 {
>>>>      compatible = "hisilicon,hi3519-sysctrl", "syscon";
>>>>      reg = <0x12010000 0x1000>;
>>>> };
>>>> Do you mean that I should remove "hisilicon,hi3519-sysctrl" and just use "syscon" as the
>>>> compatible string??
>>>
>>> Where is this compatible string _used_?
>>>
>>>> If I want to add "hisilicon,hi3519-sysctrl" for hi3519. where should I put this binding?
>>>> Could you give some suggestions?  Thank you very much!
>>>
>>> If you're not using the compatible i.e. the device doesn't have its
>>> own driver yet, then there is no need to supply the binding at all, is
>>> there?
>>>
>>
>> OK. Thank you.
>>
> 
> Sorry for stepping in late here. I still think that every syscon device should
> come with a specific compatible string, so we have the option of creating a
> driver later on, and I'd like to see a binding document that lists those strings
> (which I believe exists here).
> 
> It's really hard to add compatible strings later on, anything else we can
> work around by keying off that string and adding a workaround in the kernel.
> 

Is it OK if I put this binding document into the directory "Documentation/devicetree/bindings/arm/hisilicon"?

Thank you.

> 	Arnd
> 
> .
> 
