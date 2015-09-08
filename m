From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Sep 2015 18:46:14 -0500
Subject: [PATCH 3/3] arm64: dts: mt8173: Add nor flash node
In-Reply-To: <CAAEAJfCg+O=b9pfndG2WfxKVk9gvcqHUL0MV4fDpHj_9CaCBbQ@mail.gmail.com>
References: <1441705796-11365-1-git-send-email-bayi.cheng@mediatek.com>
 <1441705796-11365-4-git-send-email-bayi.cheng@mediatek.com>
 <CAD6G_RTR2r8ETMQ14uGosRn-85sssvVsFT4BjK9SkVSfMkG8Dw@mail.gmail.com>
 <CAAEAJfCg+O=b9pfndG2WfxKVk9gvcqHUL0MV4fDpHj_9CaCBbQ@mail.gmail.com>
Message-ID: <55EF7346.5040607@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2015 10:18 AM, Ezequiel Garcia wrote:
> On 8 September 2015 at 08:53, Jagan Teki <jteki@openedev.com> wrote:
>> On 8 September 2015 at 15:19, Bayi Cheng <bayi.cheng@mediatek.com> wrote:
>>> Add Mediatek nor flash node
>>>
>>> Signed-off-by: Bayi Cheng <bayi.cheng@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index d18ee42..a14f005 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -365,6 +365,16 @@
>>>                         status = "disabled";
>>>                 };
>>>
>>> +               nor_flash: nor at 1100d000 {
>>
>> Based on the comments from 1/3 - this notation needs to be change something like
>> qspi0: quadspi at 1100d000
>>
> 
> Actually, to follow ePAPR recomendations it should be named as flash at 1100d000.
> (See ePAPR, 2.2.2 Generic Names Recommendation).

The flash device node should, but this is the controller which should be
"spi" IMO even if this is not a general purpose controller.

Rob
