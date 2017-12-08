From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 8 Dec 2017 15:51:41 +0100
Subject: [PATCH V7 5/7] ACPI: properties: Implement get_match_data()
 callback
In-Reply-To: <1512681031-11343-6-git-send-email-okaya@codeaurora.org>
References: <1512681031-11343-1-git-send-email-okaya@codeaurora.org>
 <1512681031-11343-6-git-send-email-okaya@codeaurora.org>
Message-ID: <CAJZ5v0hr28q-xj=mYC1xdcTu5FW6cdnCZ4n9xv0fWDF6vcZygA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 10:10 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Now that we have a get_match_data() callback as part of the firmware node,
> implement the ACPI specific piece for it.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e26ea20..466d150 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -1271,9 +1271,17 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>         return 0;
>  }
>
> +static void *
> +acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
> +                                 const struct device *dev)
> +{
> +       return acpi_get_match_data(dev);
> +}
> +
>  #define DECLARE_ACPI_FWNODE_OPS(ops) \
>         const struct fwnode_operations ops = {                          \
>                 .device_is_available = acpi_fwnode_device_is_available, \
> +               .device_get_match_data = acpi_fwnode_device_get_match_data, \
>                 .property_present = acpi_fwnode_property_present,       \
>                 .property_read_int_array =                              \
>                         acpi_fwnode_property_read_int_array,            \
> --

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
