From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 10:19:14 -0500
Subject: [PATCH v3 12/18] dt-bindings: Add PLX Technology OXNAS pinctrl
 and gpio bindings
In-Reply-To: <56FE8602.8020405@baylibre.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
 <20160325144834.GA27177@rob-hp-laptop>
 <CACRpkdbem5a_aLTHErp0ZvanwvVPbGnDiWxM5e7iX_FdHtXprQ@mail.gmail.com>
 <CAL_JsqLsKEb+dWLg9VD3p=kjgEV84_r8z89p0QgMJWKqjrGNpw@mail.gmail.com>
 <56FE8602.8020405@baylibre.com>
Message-ID: <CAL_JsqJS31gNS-dYXQvkLHb=qsVz4Vccztufnd08yfD+p52v_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 1, 2016 at 9:30 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> On 03/31/2016 03:36 PM, Rob Herring wrote:
>> On Thu, Mar 31, 2016 at 3:58 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Fri, Mar 25, 2016 at 3:48 PM, Rob Herring <robh@kernel.org> wrote:
>>>> On Thu, Mar 24, 2016 at 05:50:09PM +0100, Neil Armstrong wrote:
>>>>> Add pinctrl and gpio DT bindings for PLX Technology OXNAS SoC Family.
>>>>> This version supports the ARM926EJ-S based OX810SE SoC with 34 IO pins.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>
>>>>> + - plxtech,gpio-bank: Specifies which bank a controller owns.
>>>>
>>>> How is this used?
>>>
>>> That is used to give a unique ID number to the bank.
>>>
>>> Hardware often need this to cross-reference pin controllers
>>> to GPIO banks.
>>>
>>> I should add it as "gpio-bank" to the generic bindings
>>> instead, several platforms already use this and there is
>>> no point in having a vendor prefix in front of it.
>>
>> Okay, now it is clearer. I don't want this documented as a common
>> property because I don't want to encourage it's use. I only see 2
>> users currently: ST and PIC32.
>>
>> Looking at one example, it appears to be redundant already.
>> nomadik-gpio-chips property already gives you the index. The index of
>> the phandles is the bank numbering. PIC32 could do the same.
>>
>> Rob
>>
>
> Hi,
>
> What should I use ?

Maybe gpio-ranges as you asked. Not really sure as I haven't used it.

> I need to repost in a separate patchset with vendor replaced by Oxford Semiconductor.
> Should I get rid of the vendor prefix of gpio-bank ?

No, because I think you should get rid of the property.

Rob
