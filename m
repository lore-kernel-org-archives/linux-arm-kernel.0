From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 May 2015 09:26:47 -0300
Subject: [PATCH] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5BU4msRswEujw=DC=HdsZY5S3YeG9KYNFxf3cwiFY6n2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 1:02 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> +               /* The maximum die temp is specified by the Temperature Grade */
> +               switch ((val >> 6) & 0x3) {
> +               case 0: /* Commercial (0 to 95C) */
> +                       data->temp_grade = "Commercial";
> +                       data->temp_critical = 95000;
> +                       break;
> +               case 1: /* Extended Commercial (-20 to 105C) */
> +                       data->temp_grade = "Extended Commercial";
> +                       data->temp_critical = 105000;
> +                       break;

Looks good, only a minor suggestion for consistency: could you please
change "Commercial" to "Consumer"?

This is the term that is referenced in the datasheet, so better keep
it consistent.

Thanks
