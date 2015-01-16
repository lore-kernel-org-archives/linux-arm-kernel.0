From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 16 Jan 2015 13:32:03 +0100
Subject: [PATCH 0/3] Enable myphy28lp support
In-Reply-To: <54B8FC56.8080400@st.com>
References: <1421229299-8206-1-git-send-email-gabriel.fernandez@linaro.org>
 <54B8FC56.8080400@st.com>
Message-ID: <54B904C3.1080002@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/16/2015 12:56 PM, Maxime Coquelin wrote:
> Hi Gabriel,
>
>     For the series:
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
>
>     Kishon, could you take care of adding PHY driver patch for v3.20?
Hi Kishon,

     Don't apply the patch, since we have 2 other PHY driver patches, I 
will send you a pull request.

Best regards,
Maxime


>
> Thanks,
> Maxime
> On 01/14/2015 10:54 AM, Gabriel FERNANDEZ wrote:
>> The goal of this series is to enable the support of MiPHY28lp Generic 
>> PHY.
>>
>> The first patch is to update miphy28lp phy driver to access sysconfig 
>> register
>> offsets via syscfg dt property. It's based on Arnds review comments here
>> https://lkml.org/lkml/2014/11/13/161
>> I have updated the miphy28lp phy driver same way as Peter's 
>> implementation.
>>
>> Gabriel Fernandez (3):
>>    phy: miphy28lp: Pass sysconfig register offsets via syscfg dt
>>      property.
>>    ARM: DT: STi: STiH407: Add DT node for MiPHY28lp
>>    ARM: multi_v7_defconfig: Enable MiPHY28lp - ST's Generic (SATA, 
>> PCIe &
>>      USB3) PHY
>>
>>   .../devicetree/bindings/phy/phy-miphy28lp.txt      | 43 
>> ++++++---------
>>   arch/arm/boot/dts/stih407-family.dtsi              | 53 
>> +++++++++++++++++++
>>   arch/arm/boot/dts/stihxxx-b2120.dtsi               | 11 ++++
>>   arch/arm/configs/multi_v7_defconfig                |  1 +
>>   drivers/phy/phy-miphy28lp.c                        | 61 
>> ++++++++++++----------
>>   5 files changed, 113 insertions(+), 56 deletions(-)
>>
>
