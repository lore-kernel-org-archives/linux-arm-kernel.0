From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 26 Feb 2016 12:43:15 +0200
Subject: [PATCH v2] mfd: Provide MACRO to declare commonly defined MFD
 cell attributes
In-Reply-To: <20160210153846.GB26950@x1>
References: <1455028027-1527-1-git-send-email-lee.jones@linaro.org>
 <20160210153846.GB26950@x1>
Message-ID: <CAHp75VfWdx6VfXLNt7iWSnUsD944cYv+6sa7uYD0KviJYa49oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 5:38 PM, Lee Jones <lee.jones@linaro.org> wrote:
> mfd: Provide MACRO to declare commonly defined MFD cell attributes
>

Commit message?


> +#define MFD_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))

What's wrong with ARRAY_SIZE() ?

> +
> +#define MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, _match)                \

It misses pset. Which makes below set of macros is not sufficient.

> +       {                                                               \
> +               .name = (_name),                                        \
> +               .resources = (_res),                                    \
> +               .num_resources = MFD_ARRAY_SIZE((_res)),                \
> +               .platform_data = (_pdata),                              \
> +               .pdata_size = MFD_ARRAY_SIZE((_pdata)),                 \
> +               .of_compatible = (_compat),                             \
> +               .acpi_match = (_match),                                 \
> +               .id = _id,                                              \
> +       }
> +
> +#define OF_MFD_CELL(_name, _res, _pdata, _id, _compat)                 \
> +               MFD_CELL_ALL(_name, _res, _pdata, _id, _compat, NULL)   \
> +
> +#define ACPI_MFD_CELL(_name, _res, _pdata, _id, _match)                        \
> +               MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, _match)    \
> +
> +#define MFD_CELL_BASIC(_name, _res, _pdata, _id)                       \
> +               MFD_CELL_ALL(_name, _res, _pdata, _id, NULL, NULL)      \
> +
> +#define MFD_CELL_NAME(_name)                                           \
> +               MFD_CELL_ALL(_name, NULL, NULL, 0, NULL, NULL)          \

-- 
With Best Regards,
Andy Shevchenko
