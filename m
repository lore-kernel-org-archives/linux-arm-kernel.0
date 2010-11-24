From: ccross@android.com (Colin Cross)
Date: Wed, 24 Nov 2010 15:23:01 -0800
Subject: [PATCH] usb: host: tegra: protect bus suspend with CONFIG_PM
In-Reply-To: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E5@HQMAIL03.nvidia.com>
References: <3C7A7ACA8617D24290826EC008B5CD0817D747F9E5@HQMAIL03.nvidia.com>
Message-ID: <AANLkTi=86DuOKWvkgVZ6kmDfeWioPhMbEufPW=JpQOjX@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 19, 2010 at 2:15 PM, Allen Martin <AMartin@nvidia.com> wrote:
> Protect the bus suspend/resume functions behind #ifdef CONFIG_PM.
> This prevents a compile error if CONFIG_PM is turned off.
>
> Signed-off-by: Allen Martin <amartin@nvidia.com>
> ---
> ?drivers/usb/host/ehci-tegra.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
> index e566a97..02087c8 100644
> --- a/drivers/usb/host/ehci-tegra.c
> +++ b/drivers/usb/host/ehci-tegra.c
> @@ -334,6 +334,7 @@ static int tegra_ehci_setup(struct usb_hcd *hcd)
> ? ? ? ?return retval;
> ?}
>
> +#ifdef CONFIG_PM
> ?static int tegra_ehci_bus_suspend(struct usb_hcd *hcd)
> ?{
> ? ? ? ?struct tegra_ehci_hcd *tegra = dev_get_drvdata(hcd->self.controller);
> @@ -359,6 +360,7 @@ static int tegra_ehci_bus_resume(struct usb_hcd *hcd)
>
> ? ? ? ?return ehci_bus_resume(hcd);
> ?}
> +#endif
>
> ?static const struct hc_driver tegra_ehci_hc_driver = {
> ? ? ? ?.description ? ? ? ? ? ?= hcd_name,
> --
> 1.7.2.3
>
>

Ack.  This driver is not in for-next yet, I'll pull this into the tegra tree.

Your mailer is converting = to =3d, so I had to apply this manually.
