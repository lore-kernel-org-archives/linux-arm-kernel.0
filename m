From: linux.amoon@gmail.com (Anand Moon)
Date: Mon, 13 Aug 2018 13:33:41 +0530
Subject: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
In-Reply-To: <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
References: <20180806160933.6578-1-krzk@kernel.org>
 <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
 <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com>
 <CANAwSgQBthsKMKBBnKBnCJdKwKOMm0XKRn5r=gnpdbC6Eu9=ag@mail.gmail.com>
 <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
Message-ID: <CANAwSgRJEcm8LLODKk=K_NsGjRUEXseCK-XXkNCTMoS7znQ9-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Krzysztof,
On Mon, 13 Aug 2018 at 12:43, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 13 August 2018 at 08:37, Anand Moon <linux.amoon@gmail.com> wrote:
> > Hi Krzysztof,
> >
> > On Sun, 12 Aug 2018 at 18:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 11 August 2018 at 08:39, Anand Moon <linux.amoon@gmail.com> wrote:
> >> > Hi Krzysztof,
> >> >
> >> > These patches should also be ported to u-boot to enable PMIC.
> >> >
> >> > I was just looking into S2MPS11B data sheet
> >> > According to the 1.2 Key Features of  S2MPS11
> >> >
> >> > BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
> >> > BUCK5 have (0.65 V to 2.0 V) min /max range.
> >> > BUCK7 have (1.2 V to 1.5 V) min / max range.
> >> > BUCK8 have (1.8 V to 2.1 V) min / max range.
> >> > BUCK10 have (0.75 V to 1.4 V) min / max range.
> >> >
> >> > BUCKBOST9 (3.0 V to 3.75 V) min / max range.
> >> >
> >> > LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range
> >> >
> >> > LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
> >> > LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
> >> > LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
> >> > (0.8 V to 3.95 V) min / max range
> >> >
> >> > I am aware off we have configures the min/max range as per board schematics.
> >> > but each regulator support dynamic voltage scale and have different
> >> > turn on/off voltage and current rating.
> >> >
> >> > So why are we not setting the regulator-min-microvolt /
> >> > regulator-max-microvolt as per datasheets.
> >> > Please correct me if I am wrong.
> >>
> >> Which regulators are not configured as in datasheet?
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Almost all the regulator have some miss default match of min/max setting.
> > I have tried to adjust the setting on top your above patches.
> >
> > I am attaching my patch diff for testing.
> > I have have perform some stress testing and found no issue at my end.
>
> All the regulators you touched in this patch have proper setting of
> min and max values. They are configured to the values required by
> hardware, as in schematics.
>
> Best regards,
> Krzysztof

Yes I am aware of that. Those voltage range setting from schematics
are for *default on* and *default off* of regulator state.

As per the datasheet description.

*Buck Convertors*
Each buck provides a wide range of output and Buck1, 2,3,4,6 voltage
controlled by Dynamic Voltage scale
(DVS) function through I2C control, Buck1, Buck2, Buck3, Buck4 and
Buck6 have controllable output voltage
range from 0.65 V to 1.6 V, Buck5 has controllable output voltage
range from 0.65V to 2.0V, Buck7, Buck8 and
Buck10 have controllable output voltage range from 0.75 V to 3.55 V
and BuckBoost9 has controllable output
voltage range from 3.0 V to 3.75 V. Ramp slope can be controlled from
6.25 mV/us to 50 mV/us using 2 bits.

*LDOs*
Thirty eight consisted of 31 PLDOs (PMOS-type LDo) and 7 NLDOs
(NMOS-type LDO) and integrated into
S2MPS11. PLDOs are mainly used for higher output volage rangeing from
0.8 V to 3.95 V with 5OmV step.
Their maximum output current driving capacities are 150 mA, 300 mA and 450 mA.

Best Regards
-Anand
