From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 3 Jul 2014 10:06:21 +0200
Subject: [PATCH v2 0/4] Add reset controllers for STiH407 SoC
In-Reply-To: <20140702165924.GB17665@lee--X1>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
 <1404317194.4109.13.camel@paszta.hi.pengutronix.de>
 <20140702165924.GB17665@lee--X1>
Message-ID: <53B50EFD.2070007@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/02/2014 06:59 PM, Lee Jones wrote:
> On Wed, 02 Jul 2014, Philipp Zabel wrote:
>
>> Hi Peter,
>>
>> Am Mittwoch, den 02.07.2014, 15:08 +0100 schrieb Peter Griffin:
>>> This series adds reset controller support for the STiH407 SoC.
>>>
>>> Changes since v1
>>>   - Update copyright to 2014
>>>   - Add const qualifier
>>>   - Fix various whitespace issues
>>>   - Remove THIS_OWNER
>>>   - Move DT documentation into separate patch
>>>
>>> Peter Griffin (4):
>>>    reset: stih407: Add softreset, powerdown and picophy controllers
>>>    reset: sti: Document sti-picophyreset controllers bindings.
>>>    ARM: sti: Add STiH407 Kconfig entry to select STIH407_RESET
>>>    ARM: sti: Add STiH407 reset controller support.
>>>
>>>   .../bindings/reset/st,sti-picophyreset.txt         |  42 ++++++
>>>   arch/arm/boot/dts/stih407.dtsi                     |  16 +++
>>>   arch/arm/mach-sti/Kconfig                          |  10 ++
>>>   drivers/reset/sti/Kconfig                          |   4 +
>>>   drivers/reset/sti/Makefile                         |   1 +
>>>   drivers/reset/sti/reset-stih407.c                  | 158 +++++++++++++++++++++
>>>   .../dt-bindings/reset-controller/stih407-resets.h  |  61 ++++++++
>>>   7 files changed, 292 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/reset/st,sti-picophyreset.txt
>>>   create mode 100644 drivers/reset/sti/reset-stih407.c
>>>   create mode 100644 include/dt-bindings/reset-controller/stih407-resets.h
>>
>> Looks good to me now.
>>
>> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
>
> Do you have a tree for Reset?  If not, which route do these patches
> normally follow?
>

I will queue patch 4 to STi DT branch for v3.17.
For now, no nodes uses reset for STiH407, so we don't need the 
dt-bindings header file in the STi tree.

If we have a DT node using a reset line before my pull-request, I might 
have to integrate the series in the STi DT branch.
Philipp, does that sound reasonable?

Regards,
Maxime
