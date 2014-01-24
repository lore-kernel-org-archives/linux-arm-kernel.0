From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jan 2014 14:02:35 +0800
Subject: [PATCH V2 1/8] SPEAr13xx: Set dt field entry <stmmac,phy-addr>
 for phy probe
In-Reply-To: <CAOh2x=mQLyMV_0Swf3o2c9bW_DNCLT-fQFc3Qs6yt1+9prabmw@mail.gmail.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <12754927160d11063aad96c011c4807cb0aa1775.1390471111.git.mohit.kumar@st.com>
 <CAOh2x=mQLyMV_0Swf3o2c9bW_DNCLT-fQFc3Qs6yt1+9prabmw@mail.gmail.com>
Message-ID: <CAGb2v64pSvoRBzrpzXT5yywqWSw8ryQiuVop2tMSRpU2=YMLiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 24, 2014 at 1:02 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On Thu, Jan 23, 2014 at 4:02 PM, Mohit Kumar <mohit.kumar@st.com> wrote:
>> DT field name for the phy address changed since kernel 3.10. Set the
>> snps,phy-addr to 0xffffffff so that the driver probes for the phy.

This will no longer be required. The default behavior for
DT based setups has been changed to auto-detecting the phy.

See http://patchwork.ozlabs.org/patch/312063/


Cheers
ChenYu

>>
>> Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
>> Cc: Pratyush Anand <pratyush.anand@st.com>
>> Cc: Viresh Kumar <viresh.linux@gmail.com>
>> Cc: spear-devel at list.st.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree at vger.kernel.org
>> ---
>>  arch/arm/boot/dts/spear13xx.dtsi |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
>> index 4382547..3518803 100644
>> --- a/arch/arm/boot/dts/spear13xx.dtsi
>> +++ b/arch/arm/boot/dts/spear13xx.dtsi
>> @@ -155,6 +155,7 @@
>>
>>                 gmac0: eth at e2000000 {
>>                         compatible = "st,spear600-gmac";
>> +                       snps,phy-addr = <0xffffffff>;
>>                         reg = <0xe2000000 0x8000>;
>>                         interrupts = <0 33 0x4
>>                                       0 34 0x4>;
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
