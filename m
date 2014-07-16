From: pramod.gurav.etc@gmail.com (pramod gurav)
Date: Wed, 16 Jul 2014 12:31:33 +0530
Subject: [PATCH v4 3/3] regulator: qcom-rpm: Regulator driver for the
 Qualcomm RPM
In-Reply-To: <1405465241-28684-4-git-send-email-bjorn.andersson@sonymobile.com>
References: <1405465241-28684-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1405465241-28684-4-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CAMf-jSn2YHF7ihRpXMfkPWYt8pNCj4o395OGha3BHD3K3mUv9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

On Wed, Jul 16, 2014 at 4:30 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> Driver for regulators exposed by the Resource Power Manager (RPM) found
> in Qualcomm 8660, 8960 and 8064 based devices.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> ---
>  drivers/regulator/Kconfig              |  12 +
>  drivers/regulator/Makefile             |   1 +
>  drivers/regulator/qcom_rpm-regulator.c | 787 +++++++++++++++++++++++++++++++++
>  3 files changed, 800 insertions(+)
.
.
[snip]
.
.
> + * Physically available PMIC regulator voltage ranges
> + */
> +static const struct regulator_linear_range pldo_ranges[] = {
> +       REGULATOR_LINEAR_RANGE( 750000,   0,  59, 12500),

ERROR: space prohibited after that open parenthesis '('

> +       REGULATOR_LINEAR_RANGE(1500000,  60, 123, 25000),
> +       REGULATOR_LINEAR_RANGE(3100000, 124, 160, 50000),
> +};
> +
> +static const struct regulator_linear_range nldo_ranges[] = {
> +       REGULATOR_LINEAR_RANGE( 750000,   0,  63, 12500),

Ditto.

> +};
> +
> +static const struct regulator_linear_range nldo1200_ranges[] = {
> +       REGULATOR_LINEAR_RANGE( 375000,   0,  59,  6250),
> +       REGULATOR_LINEAR_RANGE( 750000,  60, 123, 12500),

Ditto

> +};
> +
> +static const struct regulator_linear_range smps_ranges[] = {
> +       REGULATOR_LINEAR_RANGE( 375000,   0,  29, 12500),
> +       REGULATOR_LINEAR_RANGE( 750000,  30,  89, 12500),
> +       REGULATOR_LINEAR_RANGE(1500000,  90, 153, 25000),
> +};
> +
> +static const struct regulator_linear_range ftsmps_ranges[] = {
> +       REGULATOR_LINEAR_RANGE( 350000,   0,   6, 50000),
> +       REGULATOR_LINEAR_RANGE( 700000,   7,  63, 12500),
> +       REGULATOR_LINEAR_RANGE(1500000,  64, 100, 50000),
> +};

Ditto

> +
> +static const struct regulator_linear_range ncp_ranges[] = {
> +       REGULATOR_LINEAR_RANGE(1500000,   0,  31, 50000),

[snip]

> +MODULE_DESCRIPTION("Qualcomm RPM regulator driver");
> +MODULE_LICENSE("GPL v2");
> --
> 1.8.2.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
Thanks and Regards
Pramod
