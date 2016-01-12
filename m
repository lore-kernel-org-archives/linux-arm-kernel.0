From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 12 Jan 2016 08:39:46 +0000
Subject: [PATCH v5 5/6] mfd: dt-bindings: add device tree bindings for
 Hi3519 sysctrl
In-Reply-To: <5694B68A.6040300@huawei.com>
References: <1452219400-32478-1-git-send-email-xuejiancheng@huawei.com>
 <1452219400-32478-6-git-send-email-xuejiancheng@huawei.com>
 <20160111054846.GD3331@x1> <56935EA8.4060801@huawei.com>
 <20160111085555.GE14104@x1> <5694584D.7040301@huawei.com>
 <20160112074107.GK19803@x1> <5694B68A.6040300@huawei.com>
Message-ID: <20160112083946.GN19803@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jan 2016, xuejiancheng wrote:

> Hello Lee,
> 
> On 2016/1/12 15:41, Lee Jones wrote:
> > On Tue, 12 Jan 2016, xuejiancheng wrote:
> > 
> >>
> >>
> >> On 2016/1/11 16:55, Lee Jones wrote:
> >>> On Mon, 11 Jan 2016, xuejiancheng wrote:
> >>>> On 2016/1/11 13:48, Lee Jones wrote:
> >>>>> On Fri, 08 Jan 2016, Jiancheng Xue wrote:
> >>>>>
> >>>>>> Add device tree bindings for Hi3519 system controller.
> >>>>>>
> >>>>>> Signed-off-by: Jiancheng Xue <xuejiancheng@huawei.com>
> >>>>>> ---
> >>>>>>  Documentation/devicetree/bindings/mfd/hi3519.txt | 14 ++++++++++++++
> >>>>>>  1 file changed, 14 insertions(+)
> >>>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/hi3519.txt
> >>>>>
> >>>>> I have this patch, but none of the others in the set, thus I am
> >>>>> lacking context.
> >>>>>
> >>>> I can forward other patches in the set to you. Thank you.
> >>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/mfd/hi3519.txt b/Documentation/devicetree/bindings/mfd/hi3519.txt
> >>>>>> new file mode 100644
> >>>>>> index 0000000..115c5be
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/mfd/hi3519.txt
> >>>>>> @@ -0,0 +1,14 @@
> >>>>>> +* Hisilicon Hi3519 System Controller Block
> >>>>>> +
> >>>>>> +This bindings use the following binding:
> >>>>>> +Documentation/devicetree/bindings/mfd/syscon.txt
> >>>>>> +
> >>>>>> +Required properties:
> >>>>>> +- compatible: "hisilicon,hi3519-sysctrl".
> >>>>>> +- reg: the register region of this block
> >>>>>> +
> >>>>>> +Examples:
> >>>>>> +sysctrl: system-controller at 12010000 {
> >>>>>> +	compatible = "hisilicon,hi3519-sysctrl", "syscon";
> >>>>>> +	reg = <0x12010000 0x1000>;
> >>>>>> +};
> >>>>>
> >>>>> There is no requirement (nor want) for binding documents where the
> >>>>> given device is simply using highly generic bindings.  This just
> >>>>> amounts to churn.
> >>>>>
> >>>> This block is specific for Hi3519 SOC, and may has its own driver.
> >>>
> >>> Does it have its own driver currently?
> >>>
> >> Not yet.
> >> Arnd Bergmann and Rob Herring all suggested adding a specific compatible string
> >> with the SOC name. This binding is just used for describing the compatible string now.
> >> When more functions on hi3519 SOC are added later, the specific driver will be also
> >> needed.
> > 
> > Save this binding until it has more functionality.  We here "I'll add
> > to this later" all too often.
> > 
> 
> In the hi3519.dtsi file, there is a system-controller device node described like below:
> sysctrl: system-controller at 12010000 {
> 	compatible = "hisilicon,hi3519-sysctrl", "syscon";
> 	reg = <0x12010000 0x1000>;
> };
> Do you mean that I should remove "hisilicon,hi3519-sysctrl" and just use "syscon" as the
> compatible string??

Where is this compatible string _used_?

> If I want to add "hisilicon,hi3519-sysctrl" for hi3519. where should I put this binding?
> Could you give some suggestions?  Thank you very much!

If you're not using the compatible i.e. the device doesn't have its
own driver yet, then there is no need to supply the binding at all, is
there?

> >>>> So I think it's better to keep this binding.
> >>>
> >>
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
