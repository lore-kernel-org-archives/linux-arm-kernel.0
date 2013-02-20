From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 20 Feb 2013 11:31:13 -0500 (EST)
Subject: [V2 6/8] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <1360923853-7875-7-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1302201129280.1671-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013, Manjunath Goudar wrote:

> Separate the Qualcomm On-Chip host controller driver from ehci-hcd host code
> into its own driver module.

> --- a/drivers/usb/host/ehci-msm.c
> +++ b/drivers/usb/host/ehci-msm.c

> +static const char hcd_name[] = "msm_hsusb_host";

This should be something more like "ehci-msm".  Of course, that means 
you have to leave the ehci_msm_driver.driver.name field unchanged.

Alan Stern
