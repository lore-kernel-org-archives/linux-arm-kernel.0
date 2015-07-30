From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Jul 2015 22:08:10 -0500
Subject: [PATCH v2 05/22] ACPI: add acpi_dev_get_device()
In-Reply-To: <1438089593-7696-6-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438089593-7696-6-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAL_JsqKn82RqVhRRX0YPwZcfX66==1i3D43y8XLP07QARSGGrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> This function is just a getter for struct acpi_device.dev and is needed
> in the implementation of the fwnode API when building with !CONFIG_ACPI.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>
> Changes in v2:
> - Add acpi_dev_get_device()
>
>  include/linux/acpi.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 01e6770d8e27..d1ad6c20c7e4 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -78,6 +78,11 @@ static inline void acpi_preset_companion(struct device *dev,
>         ACPI_COMPANION_SET(dev, acpi_find_child_device(parent, addr, NULL));
>  }
>
> +static inline struct device *acpi_dev_get_device(struct acpi_device *adev)

get usually implies reference counting. Perhaps acpi_dev_to_device or
acpi_dev_find_device.

Rob
