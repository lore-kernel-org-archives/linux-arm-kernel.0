From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 Jul 2018 09:08:34 -0700
Subject: [PATCH v3 1/2] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
References: <20180709212522.187257-1-mka@chromium.org>
 <153149761947.48062.16210609862063613310@swboyd.mtv.corp.google.com>
Message-ID: <CAD=FV=UVUO+xhTxET_MHuk6CsSfsfRFr_ZUzM0AKW5zzMfk98A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 13, 2018 at 9:00 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Matthias Kaehlcke (2018-07-09 14:25:21)
>> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> index 92bed1e7d4bb..7eea94701b23 100644
>> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
>> @@ -11,6 +11,13 @@
>>                 #address-cells = <1>;
>>                 #size-cells = <0>;
>>
>> +               pm8998_temp: temp-alarm at 2400 {
>
> Are we sorting this file based on node name or unit address? Otherwise
> patch looks good.

My preference would be:

* Anything where we're defining a new node with an address: sort by the address.

* If we are defining nodes without addresses: sort by node name (not by label!)

* In general I'd prefer to see addressless things before things with addresses.

* If we are overriding nodes that were defined in a parent makefile:
sort by the name of the parent label we refer to.


...so I think Matthias's sort order in this case is correct / consistent.


-Doug
