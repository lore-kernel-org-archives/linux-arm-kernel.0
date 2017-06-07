From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Wed, 7 Jun 2017 18:35:48 +0200
Subject: [PATCH v2 3/7] includes: dt-bindings: Rename STM32F429 pinctrl DT
 bindings
In-Reply-To: <800a68a4-d6ce-212b-5849-56c9d32f891a@st.com>
References: <1491568984-20169-1-git-send-email-alexandre.torgue@st.com>
 <1491568984-20169-4-git-send-email-alexandre.torgue@st.com>
 <20170410202736.zy7naw74hvrdmfzk@rob-hp-laptop>
 <800a68a4-d6ce-212b-5849-56c9d32f891a@st.com>
Message-ID: <832cd436-0704-3709-ba2c-2c1f6db48615@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Gentle ping.

On 04/12/2017 03:31 PM, Alexandre Torgue wrote:
> Hi Rob,
>
> On 04/10/2017 10:27 PM, Rob Herring wrote:
>> On Fri, Apr 07, 2017 at 02:43:00PM +0200, Alexandre TORGUE wrote:
>>> STM32F4 MCU series is composed of several SOC (STM32F429, STM32F469,
>>> ...).
>>> Most of muxing definition are identical. So to avoid to duplicate
>>> bindings
>>> definition, this patch create common definitions.
>>
>> This is a lot of churn. Some confirmation that the resultant dtb is the
>> same before and after would be nice. Perhaps the script you used to
>> convert this as well.
>
> I tried to use fdtdump but it seems bugged. So I used directly dtc
> binary to (re)generate dts files (before and after apply the series) and
> I compared "pinmux" field in both case.
>
> Example on stm32f469-disco:
>
> ./scripts/dtc/dtc -I dtb -O dts -o stm32f469-disco-after.dts
> stm32f469-disco-after.dtb
>
> ./scripts/dtc/dtc -I dtb -O dts -o stm32f469-disco-before.dts
> stm32f469-disco-before.dtb
>
> cat stm32f469-disco-after.dts | grep pinmux
> cat stm32f469-disco-before.dts | grep pinmux
>

Do you agree with verifications ?

> regards
> alex
>
>>
>> Rob
>>
