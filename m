From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Sat, 08 Mar 2014 09:32:15 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzldIHVzYjogY2hpcGlkZWE6IHVzYm1pc2M6IEFkZCBV?=
 =?UTF-8?B?U0IgSG9zdCBzdXBwb3J0IGZvciBpLk1YMjUvaS5NWDM1IENQVXM=?=
In-Reply-To: <1394211863-7569-1-git-send-email-denis@eukrea.com>
References: <1394211863-7569-1-git-send-email-denis@eukrea.com>
Message-ID: <1394256735.984728060@f310.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????,  7 ????? 2014, 18:04 +01:00 ?? Denis Carikli <denis@eukrea.com>:
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  drivers/usb/chipidea/usbmisc_imx.c |   59 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index cd061ab..d956ad0 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
...
> +		val = readl(usbmisc->base);
> +		val &= ~(MX25_OTG_SIC_MASK | MX25_OTG_PP_BIT);
> +		val |= (MXC_EHCI_INTERFACE_DIFF_UNI & MXC_EHCI_INTERFACE_MASK) << MX25_OTG_SIC_SHIFT;
> +		val |= (MX25_OTG_PM_BIT | MX25_OTG_OCPOL_BIT);
> +		writel(val, usbmisc->base);

At the moment, we only enable/disable interface and manage overcurrent option
in the usbmisc driver.
Is it worth it to handle type of interface here?

---
