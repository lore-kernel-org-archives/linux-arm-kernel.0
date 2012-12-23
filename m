From: marex@denx.de (Marek Vasut)
Date: Sun, 23 Dec 2012 04:24:16 +0100
Subject: [PATCH 1/2] ARM: pxa: palm27x: fix udc device initialization
In-Reply-To: <1356200860-3241-2-git-send-email-mikedunn@newsguy.com>
References: <1356200860-3241-1-git-send-email-mikedunn@newsguy.com>
 <1356200860-3241-2-git-send-email-mikedunn@newsguy.com>
Message-ID: <201212230424.16848.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mike Dunn,

> This patch fixes some bad behaviour from the usb gadget during machine
> initialization by changing the management of the D+ pull-up gpio from the
> gpio-vbus driver to the pxa27x-udc driver.  Also, code that drives the
> pull-up high is removed.  (The gpio-vbus driver can optionally manage the
> D+ line pull-up, but the pxa27x-udc driver does this itself.)
> 
> Without this patch, the host senses the presence of the usb gadget during
> machine initialization (when palm27x_udc_init() runs), at which point it
> tries to enumerate the newly detected usb gadget.  But because the
> pxa27x-udc driver has not been initialized yet, there's no gadget driver
> to respond to the host, and enumeration fails.  Tested on my Palm Treo680.
[...]

I think it was the whole big idea to let gpio-vbus manage this kind of stuff. 
But it's been a while, Ccing Haojian to review these.

Best regards,
Marek Vasut
