From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Jun 2016 15:16:07 +0200
Subject: [PATCH 3/5] ARM: dts: add L2CC and RPM with regulators for MSM8660
In-Reply-To: <20160614185517.GG28218@codeaurora.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
 <1465918259-11138-4-git-send-email-linus.walleij@linaro.org>
 <20160614185517.GG28218@codeaurora.org>
Message-ID: <CACRpkdZFGUKWiA21j2z4jxMOC=zg8oqC93YjkZR57xumxyJRQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 8:55 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/14, Linus Walleij wrote:

>> +                     rpmcc: clock-controller {
>> +                             compatible      = "qcom,rpmcc-apq8660", "qcom,rpmcc";
>> +                             #clock-cells = <1>;
>> +                     };
>
> This driver isn't merged yet, but ok.

It's there because it is there in
arch/arm/boot/dts/qcom-apq8064.dtsi

>> +
>> +                     pm8901-regulators {
>
> I'd rather have regulators at 8901 and regulators at 8058. That way the
> node name is generic per ePAPR suggestions.

Seems impossible if I should conclude the other discussion...

>> +                             pm8058_mvs: mvs {};
>
> pm8901_mvs?

Ooops fixing.

>> +                     pm8058-regulators {
>> +                             compatible = "qcom,rpm-pm8058-regulators";
>> +
>> +                             pm8058_l0: l0 {};
>> +                             pm8058_l1: l1 {};
>> +                             pm8058_l2: l2 {};
>> +                             pm8058_l3: l3 {};
>> +                             pm8058_l4: l4 {};
>> +                             pm8058_l5: l5 {};
>> +                             pm8058_l6: l6 {};
>> +                             pm8058_l7: l7 {};
>> +                             pm8058_l8: l8 {};
>> +                             pm8058_l9: l9 {};
>> +                             pm8058_l10: l10 {};
>> +                             pm8058_l11: l11 {};
>> +                             pm8058_l12: l12 {};
>> +                             pm8058_l13: l13 {};
>> +                             pm8058_l14: l14 {};
>> +                             pm8058_l15: l15 {};
>> +                             pm8058_l16: l16 {};
>> +                             pm8058_l17: l17 {};
>> +                             pm8058_l18: l18 {};
>> +                             pm8058_l19: l19 {};
>> +                             pm8058_l20: l20 {};
>> +                             pm8058_l21: l21 {};
>> +                             pm8058_l22: l22 {};
>> +                             pm8058_l23: l23 {};
>> +                             pm8058_l24: l24 {};
>> +                             pm8058_l25: l25 {};
>> +
>> +                             pm8058_s0: s0 {};
>> +                             pm8058_s1: s1 {};
>
> Just leave these out? RPM shouldn't be touching s0 or s1.

Really? The msm-3.4 tree does:

        /* RPM early regulator constraints */
        static struct rpm_regulator_init_data
rpm_regulator_early_init_data[] = {
        /*       ID       a_on pd ss min_uV   max_uV   init_ip    freq */
        RPM_SMPS(PM8058_S0, 0, 1, 1,  500000, 1325000, SMPS_HMIN, 1p60),
        RPM_SMPS(PM8058_S1, 0, 1, 1,  500000, 1250000, SMPS_HMIN, 1p60),

Are you sure you don't mean s0+s1 on PM8901 (which I left out)?

Yours,
Linus Walleij
