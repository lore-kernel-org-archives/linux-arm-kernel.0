From: rajeev-dlh.kumar@st.com (Rajeev kumar)
Date: Thu, 12 Dec 2013 09:29:30 +0530
Subject: [PATCH 01/12] SPEAr13xx: Correct dt field name for stmmac phy-addr
In-Reply-To: <001b01cef6d2$9104f7b0$b30ee710$%han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <1078549fa412fb34ab2c95a6232096570abee12d.1386752447.git.mohit.kumar@st.com>
 <52A847D1.5000409@st.com> <001b01cef6d2$9104f7b0$b30ee710$%han@samsung.com>
Message-ID: <52A934A2.8020101@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2013 6:09 AM, Jingoo Han wrote:
> On Wednesday, December 11, 2013 8:09 PM, Rajeev kumar wrote:
>> On 12/11/2013 3:08 PM, Mohit KUMAR wrote:
>>> DT field name for the phy address changed since kernel 3.10. Set the
>>> snps,phy-addr to 0xffffffff so that the driver probes for the phy.
>>>
>>> Signed-off-by: Mohit Kumar<mohit.kumar@st.com>
>>> Cc: Pratyush Anand<pratyush.anand@st.com>
>>> Cc: Viresh Kumar<viresh.linux@gmail.com>
>>> Cc: spear-devel at list.st.com
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree at vger.kernel.org
>>> ---
>>>    arch/arm/boot/dts/spear13xx.dtsi |    1 +
>>>    1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
>>> index 4382547..3518803 100644
>>> --- a/arch/arm/boot/dts/spear13xx.dtsi
>>> +++ b/arch/arm/boot/dts/spear13xx.dtsi
>>> @@ -155,6 +155,7 @@
>>>
>>>    		gmac0: eth at e2000000 {
>>>    			compatible = "st,spear600-gmac";
>>> +			snps,phy-addr =<0xffffffff>;
>>
>> Don't you think it should be st,phy-addr =<0xffffffff>, as the
>> manufacturer is 'st' as the compatible suggest
>
> Hi Rajeev Kumar,
>
> According to the Documentation, it guides to use 'snps' prefix.
>
> In my humble opinion,
> 'gmac' is a Synopsys based IP. Thus, if 'snps,phy-addr' is
> not ST specific, 'snps' prefix can be used.
>


Very much true, I raise the point just becuase compatible = 
"st,spear600-gmac". Check the manufacturer name here.

~Rajeev

> ./Documentation/devicetree/bindings/net/stmmac.txt
> - snps,phy-addr         phy address to connect to.
>
> Best regards,
> Jingoo Han
>
