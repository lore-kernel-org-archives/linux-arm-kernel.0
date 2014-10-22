From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 22 Oct 2014 10:50:12 +0530
Subject: [PATCH v3 2/8] phy: miphy28lp: Add MiPHY28lp header file for
 DT x Driver defines
In-Reply-To: <CAG374jCq1b14N_k3_j4WY-yGcXm7ChFQat5mUqgs6ZQ=UP397g@mail.gmail.com>
References: <1411721657-9924-1-git-send-email-gabriel.fernandez@linaro.org>	<1411721657-9924-3-git-send-email-gabriel.fernandez@linaro.org>	<544637A3.8010002@ti.com>
 <CAG374jCq1b14N_k3_j4WY-yGcXm7ChFQat5mUqgs6ZQ=UP397g@mail.gmail.com>
Message-ID: <54473E8C.20303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 21 October 2014 09:19 PM, Gabriel Fernandez wrote:
> Hi Kishon,
> 
> To be sure, if i rename MIPHY_TYPE_SATA into PHY_TYPE_SATA, i have to
> rename the filename also ?
> 
> include/dt-bindings/phy/phy-miphy.h into include/dt-bindings/phy/phy.h
> 
> am I right?

That's right..

Cheers
Kishon
> 
> Best Regards
> 
> Gabriel
> 
> On 21 October 2014 12:38, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> Hi Gabriel,
>>
>> On Friday 26 September 2014 02:24 PM, Gabriel FERNANDEZ wrote:
>>> This provides the shared header file which will be reference from both
>>> the MiPHY28lp driver and its associated Device Tree node(s).
>>>
>>> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
>>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>>> ---
>>>  include/dt-bindings/phy/phy-miphy.h | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>  create mode 100644 include/dt-bindings/phy/phy-miphy.h
>>>
>>> diff --git a/include/dt-bindings/phy/phy-miphy.h b/include/dt-bindings/phy/phy-miphy.h
>>> new file mode 100644
>>> index 0000000..9bc49b9
>>> --- /dev/null
>>> +++ b/include/dt-bindings/phy/phy-miphy.h
>>> @@ -0,0 +1,12 @@
>>> +/*
>>> + * This header provides constants for the phy framework
>>> + * based on the STMicroelectronics miphxxxx.
>>> + */
>>> +#ifndef _DT_BINDINGS_PHY_MIPHY
>>> +#define _DT_BINDINGS_PHY_MIPHY
>>> +
>>> +#define MIPHY_TYPE_SATA              1
>>> +#define MIPHY_TYPE_PCIE              2
>>> +#define MIPHY_TYPE_USB               3
>>
>> Since these PHY types are common across SoCs, we can have something like
>> PHY_TYPE_SATA, PHY_TYPE_PCIE so that each SoCs don't have to create a separate
>> header file.
>>
>> Cheers
>> Kishon
