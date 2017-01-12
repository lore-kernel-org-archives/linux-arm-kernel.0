From: steve_longerbeam@mentor.com (Steve Longerbeam)
Date: Thu, 12 Jan 2017 15:40:04 -0800
Subject: [PATCH v3 10/24] ARM: dts: imx6-sabreauto: add pinctrl for gpt
 input capture
In-Reply-To: <CAJ+vNU1ci=fbeemJcBGCAk40PETdcov7Fm112F5FePL9SR4cFQ@mail.gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-11-git-send-email-steve_longerbeam@mentor.com>
 <CAJ+vNU1ci=fbeemJcBGCAk40PETdcov7Fm112F5FePL9SR4cFQ@mail.gmail.com>
Message-ID: <2f015318-7afe-9d57-872a-4a55c4171ee4@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/12/2017 11:37 AM, Tim Harvey wrote:
> On Fri, Jan 6, 2017 at 6:11 PM, Steve Longerbeam <slongerbeam@gmail.com> wrote:
>> Add pinctrl groups for both GPT input capture channels.
>>
>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>> ---
>>   arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> index 967c3b8..495709f 100644
>> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
>> @@ -457,6 +457,18 @@
>>                          >;
>>                  };
>>
>> +               pinctrl_gpt_input_capture0: gptinputcapture0grp {
>> +                       fsl,pins = <
>> +                               MX6QDL_PAD_SD1_DAT0__GPT_CAPTURE1       0x1b0b0
>> +                       >;
>> +               };
>> +
>> +               pinctrl_gpt_input_capture1: gptinputcapture1grp {
>> +                       fsl,pins = <
>> +                               MX6QDL_PAD_SD1_DAT1__GPT_CAPTURE2       0x1b0b0
>> +                       >;
>> +               };
>> +
>>                  pinctrl_spdif: spdifgrp {
>>                          fsl,pins = <
>>                                  MX6QDL_PAD_KEY_COL3__SPDIF_IN 0x1b0b0
>> --
> Steve,
>
> These are not used anywhere.

Yes, maybe I should just remove this patch for now. I'm only keeping it
because eventually it will be needed to support i.MX6 input capture.

Steve
