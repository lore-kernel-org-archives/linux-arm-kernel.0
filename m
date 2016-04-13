From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Wed, 13 Apr 2016 13:58:02 +0800
Subject: [PATCH v2 1/2] dt/bindings: Add bindings for hisilicon random
 number generator
In-Reply-To: <CAL_JsqJv57nX7a89OR8U1=m+MLQKJBCOeuORPWXwGRx_P9XXBQ@mail.gmail.com>
References: <1460017397-30996-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460017397-30996-2-git-send-email-wangkefeng.wang@huawei.com>
 <20160411144306.GA24637@rob-hp-laptop> <570C4C52.4020902@huawei.com>
 <CAL_JsqJv57nX7a89OR8U1=m+MLQKJBCOeuORPWXwGRx_P9XXBQ@mail.gmail.com>
Message-ID: <570DDFEA.4090103@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/4/12 21:54, Rob Herring wrote:
> On Mon, Apr 11, 2016 at 8:16 PM, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>
>>
>> On 2016/4/11 22:43, Rob Herring wrote:
>>> On Thu, Apr 07, 2016 at 04:23:16PM +0800, Kefeng Wang wrote:
>>>> Document the devicetree bindings for the random number generator found
>>>> on Hisilicon Hip04 and Hip05 soc.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/rng/hisi-rng.txt | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/rng/hisi-rng.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/rng/hisi-rng.txt b/Documentation/devicetree/bindings/rng/hisi-rng.txt
>>>> new file mode 100644
>>>> index 0000000..72efcc1
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/rng/hisi-rng.txt
>>>> @@ -0,0 +1,12 @@
>>>> +Hisilicon Random Number Generator
>>>> +
>>>> +Required properties:
>>>> +- compatible : Should be "hisilicon,rng"
>>>> +- reg : Offset and length of the register set of this block
>>>> +
>>>> +Example:
>>>> +
>>>> +rng at d1010000 {
>>>> +    compatible = "hisilicon,rng";
>>>
>>> This still needs SoC specific compatible strings.
>>
>> It is used by Hip04/Hip05 at lease, but for new SoC, like Hip06, it maybe different,
>> using single Soc prefix is not proper, how about hisilicon,rng-v1, or add two compatible
>> hisilicon,hip04-rng and hisilicon,hip05-rng? What's your option?
> 
> It is perfectly fine to include hisilicon,hip04-rng string for hip05
> and later if the block is the same. You should still have both strings
> (the original and current SoC) in case there is some issue or
> difference found.
> 
> Unless there is a real IP version defined, you should avoid made up
> version numbers.
> 

Ok, will add both of them in v4, thanks.


> Rob
> 
> .
> 
