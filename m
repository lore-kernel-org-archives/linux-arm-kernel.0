From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 13:31:38 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <DB5PR0401MB19259C5DBD40BEEC70F0B7CEF5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <3189648.KnWLgq0lTY@wuerfel>
 <DB5PR0401MB19259C5DBD40BEEC70F0B7CEF5F60@DB5PR0401MB1925.eurprd04.prod.outlook.com>
Message-ID: <3596831.dckG5peiyF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 21, 2016 11:06:47 AM CEST Sriram Dash wrote:
> 
> Hello Arnd,
> 
> We tried this patch on NXP platforms (ls2085 and ls1043) which use dwc3 
> controller without any glue layer. On first go, this did not work. But after
> minimal reworks mention snippet below, we are able to verify that the USB
> was working OK.
> 
>  drivers/usb/host/xhci-mem.c | 12 ++++++------
>  drivers/usb/host/xhci.c     | 20 ++++++++++----------
> 
> -       struct device *dev = xhci_to_hcd(xhci)->self.controller;
> +       struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
> 
> We believe the patch needs little modification to work or there might be chances
> we may have missed something. Any idea?


I had not tried the patch, it was just sent for clarification what I
meant, so I'm glad you got it working with just minimal changes.

Unfortunately, I can't tell from your lines above what exactly you
changed, can you send that again as a proper patch?

I think I also had some minimal changes that I did myself in order
to fix a build regression I introduced.

	Arnd
