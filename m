From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 6 Feb 2016 20:42:24 +0800
Subject: [PATCH 07/11] ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
In-Reply-To: <20160202121733.GO4455@sirena.org.uk>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-8-git-send-email-wens@csie.org>
 <20160202121733.GO4455@sirena.org.uk>
Message-ID: <CAGb2v657zYT30KbuK0fyVOmhv0kzJjj9gTsTFRaS4i3d6YhiHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 8:17 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Feb 02, 2016 at 06:27:40PM +0800, Chen-Yu Tsai wrote:
>
>> +             reg_dcdc1: dcdc1 {
>> +                     regulator-name = "dcdc1";
>> +             };
>
> Why is this generic DTS include specifying regulator names?

My intent is to provide better looking names by default.
I just realized I could do this in the driver by replacing
a few fields.

But I still might need to do this for the AXP806, which
is a slave PMIC also used with A80 SoCs. The names overlap
with the AXP809. Allwinner gets around this by adding a
"s_" prefix to them. I suppose that works too.

Mark, may I assume you are OK with this DTS include listing
the regulators, even if their sections are empty?

>
>> +             reg_rtc_ldo: rtc_ldo {
>> +                     /* RTC_LDO is a fixed, always-on regulator */
>> +                     regulator-always-on;
>> +                     regulator-min-microvolt = <1800000>;
>> +                     regulator-max-microvolt = <1800000>;
>
> If the regulator itself is limited in this way there is no need to
> specify this in the DTS.

Will remove.

Thanks
ChenYu
