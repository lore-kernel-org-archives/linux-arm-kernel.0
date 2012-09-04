From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 5 Sep 2012 07:37:10 +1000
Subject: [PATCH] bus: fix omap compile error if CONFIG_OF is true
In-Reply-To: <20120904144123.25261.79625.stgit@localhost.localdomain>
References: <20120904144123.25261.79625.stgit@localhost.localdomain>
Message-ID: <20120905073710.566eabb8561b1a701a58e438@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Tue, 04 Sep 2012 15:41:35 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> From: Alan Cox <alan@linux.intel.com>
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/bus/omap-ocp2scp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/omap-ocp2scp.c b/drivers/bus/omap-ocp2scp.c
> index 9075ef8..ff63560 100644
> --- a/drivers/bus/omap-ocp2scp.c
> +++ b/drivers/bus/omap-ocp2scp.c
> @@ -67,7 +67,7 @@ static const struct of_device_id omap_ocp2scp_id_table[] = {
>  	{ .compatible = "ti,omap-ocp2scp" },
>  	{}
>  };
> -MODULE_DEVICE_TABLE(of, omap_usb2_id_table);
> +MODULE_DEVICE_TABLE(of, omap_ocp2scp_id_table);
>  #endif
>  
>  static struct platform_driver omap_ocp2scp_driver = {

This was caused by commit 26a84b3eaef0 ("drivers: bus: add a new driver
for omap-ocp2scp") which has been in the arm-soc tree for a few days ...

Thanks, Alan.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120905/71c9693f/attachment.sig>
