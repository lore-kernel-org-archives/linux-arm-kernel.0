From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 7 Mar 2018 08:18:33 +0530
Subject: [PATCH 1/3] arm64: dts: msm8916: Add cpu cooling maps
In-Reply-To: <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
 <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
 <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
Message-ID: <CAOh2x=n0zQMCtC2=NF9rRbSkNUrUJBxu1KWAoOpDh3CBDkCFgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 8:13 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Mar 6, 2018 at 7:05 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:

>>         model = "Qualcomm Technologies, Inc. MSM8916";
>> @@ -115,6 +116,10 @@
>>                         cpu-idle-states = <&CPU_SPC>;
>>                         clocks = <&apcs 0>;
>>                         operating-points-v2 = <&cpu_opp_table>;
>> +                       /* cooling options */
>> +                       cooling-min-level = <0>;
>> +                       cooling-max-level = <7>;
>
> Viresh is working on removing these from the binding...

Yep, just drop all cooling-{min|max}-level lines from your code. That
is not used
anywhere by the kernel.
