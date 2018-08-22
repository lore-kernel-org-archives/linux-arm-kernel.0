From: dianders@chromium.org (Doug Anderson)
Date: Wed, 22 Aug 2018 10:38:28 -0700
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB
 regulators
In-Reply-To: <153478912722.28926.1278085207557745493@swboyd.mtv.corp.google.com>
References: <20180810215150.82490-1-dianders@chromium.org>
 <20180810215150.82490-3-dianders@chromium.org>
 <153478912722.28926.1278085207557745493@swboyd.mtv.corp.google.com>
Message-ID: <CAD=FV=VY-n2maPD6Pyy-XQqppPrTnN2yM9SxsFEhmY0FZ9U8mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 20, 2018 at 11:18 AM, Stephen Boyd <swboyd@chromium.org> wrote:
> Quoting Douglas Anderson (2018-08-10 14:51:49)
>> @@ -20,6 +21,450 @@
>>         chosen {
>>                 stdout-path = "serial0:115200n8";
>>         };
>> +
>> +       vph_pwr: vph-pwr-regulator {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vph_pwr";
>> +               regulator-min-microvolt = <3700000>;
>> +               regulator-max-microvolt = <3700000>;
>> +       };
>> +
>> +       /*
>> +        * Apparently RPMh does not provide support for PM8998 S4 because it
>> +        * is always-on; model it as a fixed regulator.
>> +        */
>> +       vreg_s4a_1p8: pm8998-smps4 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "vreg_s4a_1p8";
>> +
>> +               regulator-min-microvolt = <1800000>;
>> +               regulator-max-microvolt = <1800000>;
>> +
>> +               regulator-always-on;
>> +               regulator-boot-on;
>
> Can vin be vph_pwr? That would properly model this.

Yes, good suggestion.  Fixed in v3.

-Doug
