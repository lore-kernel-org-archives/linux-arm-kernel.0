From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 11 Jan 2016 16:45:20 +0200
Subject: [PATCH v5 1/2] ACPI: introduce a function to find the first
 physical device
In-Reply-To: <1452518790-27053-2-git-send-email-aleksey.makarov@linaro.org>
References: <1452518790-27053-1-git-send-email-aleksey.makarov@linaro.org>
 <1452518790-27053-2-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <CAHp75Vc9U9Zw30i5gf-LPH+ms7zO9p=kSTVKjNe8MqTHf4TiCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ One more thing

On Mon, Jan 11, 2016 at 3:26 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:

> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -478,24 +478,36 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device)
>                               Device Matching
>     -------------------------------------------------------------------------- */
>
> -static struct acpi_device *acpi_primary_dev_companion(struct acpi_device *adev,
> -                                                     const struct device *dev)
> +/**
> + * acpi_device_fix_parent - Get first physical node of an ACPI device
> + * @adev: ACPI device in question
> + */

> +struct device *acpi_get_first_physical_node(
> +       struct acpi_device *adev)

One line (even if it goes a bit over 80)

-- 
With Best Regards,
Andy Shevchenko
