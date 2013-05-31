From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 31 May 2013 10:07:35 -0400 (EDT)
Subject: [PATCH V2 1/2] USB: OHCI: make ohci-platform a separate driver
In-Reply-To: <51a892db.3077420a.5699.0f88@mx.google.com>
Message-ID: <Pine.LNX.4.44L0.1305311005520.1276-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 May 2013 manjunath.goudar at linaro.org wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> This patch splits the ohci-platform code from ohci-hcd out
> into its own separate driver module.This work is part of enabling
> multi-platform kernels on ARM.
> 
> In V2:
>   -Passed "hcd" argment instead of "ohci" in ohci_setup() because it is
>    using "struct usb_hcd" argment.

> @@ -30,58 +42,17 @@ static int ohci_platform_reset(struct usb_hcd *hcd)

...

> +	return ohci_setup(ohci_to_hcd(ohci));

You don't need to use ohci_to_hcd(), because the hcd value is already a 
parameter in this function.

Alan Stern
