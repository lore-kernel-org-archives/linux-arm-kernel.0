From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 08 Feb 2013 07:54:18 +1300
Subject: [PATCH 08/10] USB: EHCI: make ehci-vt8500 a separate driver
In-Reply-To: <5113e626.c84e420a.08c3.ffffbf07@mx.google.com>
References: <yes> <1360258447-27247-1-git-send-email-yes>
 <5113e626.c84e420a.08c3.ffffbf07@mx.google.com>
Message-ID: <1360263258.25382.4.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-07 at 23:04 +0530, manjunath.goudar at linaro.org wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the vt8500 host controller driver from ehci-hcd host code
> into its own driver module.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Tony Prisk <linux@prisktech.co.nz>
> Cc: Alexey Charkov <alchark@gmail.com>
> Cc: linux-usb at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/usb/host/Kconfig       |    8 +++++
>  drivers/usb/host/Makefile      |    1 +
>  drivers/usb/host/ehci-hcd.c    |    5 ---
>  drivers/usb/host/ehci-vt8500.c |   73 ++++++++++++++++++----------------------
>  4 files changed, 42 insertions(+), 45 deletions(-)
> 
...
> diff --git a/drivers/usb/host/ehci-vt8500.c b/drivers/usb/host/ehci-vt8500.c
> index 11695d5..ff4e3ae 100644
> --- a/drivers/usb/host/ehci-vt8500.c
> +++ b/drivers/usb/host/ehci-vt8500.c
> @@ -16,52 +16,25 @@
...
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_AUTHOR("Alexey Charkov");
> +MODULE_LICENSE("GPL");
Should be "GPL v2" as per the license header.

>  MODULE_ALIAS("platform:vt8500-ehci");
>  MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);

Regards
Tony Prisk
