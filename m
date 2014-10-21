From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 21 Oct 2014 16:00:15 +0200
Subject: [PATCH v2 6/7] arm64: dts: Add nodes for mmc, i2c, rtc, watchdog
 on Exynos7
In-Reply-To: <CAGOxZ50=1ebU=8r6S_4rbL=82zb3asFTGEjkzNrJPjTkjEGfXg@mail.gmail.com>
References: <1413870237-1821-1-git-send-email-a.kesavan@samsung.com>
 <1413870237-1821-7-git-send-email-a.kesavan@samsung.com>
 <CAGOxZ50=1ebU=8r6S_4rbL=82zb3asFTGEjkzNrJPjTkjEGfXg@mail.gmail.com>
Message-ID: <544666EF.9000606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.10.2014 15:52, Alim Akhtar wrote:
>> +&mmc_0 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       broken-cd;
>> +       caps2-mmc-hs200-1_8v;
> Please use mmc_hs200-1_8v instead.

I guess you mean "mmc-hs200-1_8v" (with a hyphen between mmc and hs200).

>> +       supports-highspeed;
> As per synopsys-dw-mshc DT binding documentation, supports-highspeed
> property is deprecated, so please use common DT binding for this,
> which is "cap-mmc-highspeed".
>> +       non-removable;
>> +       card-detect-delay = <200>;
>> +       clock-frequency = <800000000>;
>> +       samsung,dw-mshc-ciu-div = <3>;
>> +       samsung,dw-mshc-sdr-timing = <0 4>;
>> +       samsung,dw-mshc-ddr-timing = <0 2>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_qrdy &sd0_bus1 &sd0_bus4 &sd0_bus8>;
>> +       bus-width = <8>;
>> +};
>> +
>> +&mmc_2 {
>> +       status = "okay";
>> +       num-slots = <1>;
>> +       supports-highspeed;
> Here also common DT binding please "cap-sd-highspeed"

Above you suggest "cap-mmc-highspeed" to replace the same deprecated
property, but here "cap-sd-highspeed". What is the rationale behind
using only one particular new property and not both for both controllers?

Best regards,
Tomasz
