From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 5 Dec 2017 15:21:46 -0600
Subject: [PATCH V6 4/7] OF: properties: Implement get_match_data() callback
In-Reply-To: <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
References: <1512493493-6464-1-git-send-email-okaya@codeaurora.org>
 <1512493493-6464-5-git-send-email-okaya@codeaurora.org>
Message-ID: <CAL_Jsq+X1MjQGyNjvZOipL3h9TRN8oWeFhPudZrvscXh1y740Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 11:04 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> Now that we have a get_match_data() callback as part of the firmware node,
> implement the OF specific piece for it.
>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/of/property.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 264c355..9964169 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -981,6 +981,12 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>         return 0;
>  }
>
> +void *of_fwnode_get_match_data(const struct fwnode_handle *fwnode,

Should be static. With that, for patches 3 and 4:

Reviewed-by: Rob Herring <robh@kernel.org>

> +                              struct device *dev)
> +{
> +       return (void *)of_device_get_match_data(dev);
> +}
> +
>  const struct fwnode_operations of_fwnode_ops = {
>         .get = of_fwnode_get,
>         .put = of_fwnode_put,
> @@ -996,5 +1002,6 @@ static int of_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>         .graph_get_remote_endpoint = of_fwnode_graph_get_remote_endpoint,
>         .graph_get_port_parent = of_fwnode_graph_get_port_parent,
>         .graph_parse_endpoint = of_fwnode_graph_parse_endpoint,
> +       .get_match_data = of_fwnode_get_match_data,
>  };
>  EXPORT_SYMBOL_GPL(of_fwnode_ops);
> --
> 1.9.1
>
