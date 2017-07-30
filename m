From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Sun, 30 Jul 2017 21:10:59 +0300
Subject: [PATCH 1/6] drm/tinydrm: Add parameter for MIPI DCS pixel format
In-Reply-To: <1501355870-13960-2-git-send-email-david@lechnology.com>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-2-git-send-email-david@lechnology.com>
Message-ID: <CAHp75Vd9=gK3tsXbw5=7j75BJkOJVkqf7rf7WRQ9gF5+XP19cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> This adds a parameter for MIPI DCS pixel format to mipi_dbi_init().
> This is in preparation for supporting displays that don't use a 16bpp
> memory layout.

>  /* MIPI DCS pixel formats */
> -#define MIPI_DCS_PIXEL_FMT_24BIT       7
> -#define MIPI_DCS_PIXEL_FMT_18BIT       6
> -#define MIPI_DCS_PIXEL_FMT_16BIT       5
> -#define MIPI_DCS_PIXEL_FMT_12BIT       3
> -#define MIPI_DCS_PIXEL_FMT_8BIT                2
> -#define MIPI_DCS_PIXEL_FMT_3BIT                1
> +enum mipi_dcs_pixel_format {
> +       MIPI_DCS_PIXEL_FMT_24BIT        = 7,
> +       MIPI_DCS_PIXEL_FMT_18BIT        = 6,
> +       MIPI_DCS_PIXEL_FMT_16BIT        = 5,
> +       MIPI_DCS_PIXEL_FMT_12BIT        = 3,
> +       MIPI_DCS_PIXEL_FMT_8BIT         = 2,
> +       MIPI_DCS_PIXEL_FMT_3BIT         = 1,
> +};

May I ask what prevents us to arrange enums in natural
 ordering (you may keep = X parts, of course)?

-- 
With Best Regards,
Andy Shevchenko
