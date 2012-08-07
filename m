From: Dongjin.Kim@agreeyamobility.net (Dongjin Kim)
Date: Tue, 7 Aug 2012 19:50:11 +0000
Subject: =?ks_c_5601-1987?B?yLi9xTogW1BBVENIIDEvNF0gYXJtL2R0czogbWF4Nzc2ODY6IEFk?=
 =?ks_c_5601-1987?Q?d_DTS_file_for_max77686_PMIC?=
In-Reply-To: <20120807193413.GE14711@sirena.org.uk>
References: <1344366267-18971-1-git-send-email-dongjin.kim@agreeyamobility.net>,
 <20120807193413.GE14711@sirena.org.uk>
Message-ID: <A6A3B7488C419F488E5B13FFD03C08AD2F4372BC@SN2PRD0510MB370.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Are you meaning VDD_MIF_1.0V, for example, would be replaced with another common name for other boards and my board file, exynos4412-odroidx.dts, describe the name again if necessary? Like below?

max77686.dtsi:
    buck1 {
         regulator-compatible = "BUCK1";
         regulator-name = "VDD_BUCK1_1.0V";
         regulator-min-microvolt = <800000>;
         regulator-max-microvolt = <1050000>;
         regulator-always-on;
         regulator-boot-on;
    };

my board's DTS file:
    buck1 {
        regulator-name = "VDD_MIF_1.0V";
    }

Thank you in advance.
Dongjin.
________________________________________
?? ??: Mark Brown [broonie at opensource.wolfsonmicro.com]
?? ??: 2012? 8? 8? ??? ?? 4:34
?? ??: Dongjin Kim
??: Russell King; linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Dongjin Kim
??: Re: [PATCH 1/4] arm/dts: max77686: Add DTS file for max77686 PMIC

On Wed, Aug 08, 2012 at 04:04:11AM +0900, Dongjin Kim wrote:

> +                     buck1 {
> +                             regulator-compatible = "BUCK1";
> +                             regulator-name = "VDD_MIF_1.0V";
> +                             regulator-min-microvolt = <800000>;
> +                             regulator-max-microvolt = <1050000>;
> +                             regulator-always-on;
> +                             regulator-boot-on;
> +                     };

These settings for the regulators are clearly specific to the board
rather than the device so should be in the board file.
