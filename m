From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 30 May 2013 13:23:26 -0400 (EDT)
Subject: [RFC PATCH 1/2] USB: OHCI: make ohci-platform a separate driver
In-Reply-To: <1369907454-11003-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305301321340.1137-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 May 2013, Manjunath Goudar wrote:

> This patch splits the ohci-platform code from ohci-hcd out
> into its own separate driver module.This work is part of enabling
> multi-platform kernels on ARM.

Okay, except...

> +static const struct ohci_driver_overrides platform_overrides = {
> +	.product_desc =	"Generic Platform EHCI controller",
> +	.reset =	ohci_platform_reset,
>  };

Don't forget the __initconst annotation.  After that is fixed, you can 
add my Acked-by.

Alan Stern
