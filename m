From: B29397@freescale.com (Chen Peter-B29397)
Date: Tue, 26 Jun 2012 02:05:05 +0000
Subject: [Patch v5 08/13] ARM: imx6q: add config-on-boot gpios
In-Reply-To: <4FE8871B.7060408@wwwdotorg.org>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <1339590863-10564-9-git-send-email-richard.zhao@freescale.com>
 <4FD8AD42.6010702@gmail.com> <20120613152841.GA23590@richard-laptop>
 <4FD8C4DB.4020908@gmail.com>
 <20120614013343.GD29684@b20223-02.ap.freescale.net>
 <4FE1DE53.4070202@gmail.com> <4FE1EF26.9080401@wwwdotorg.org>
 <F281D0F91ED19E4D8E63A7504E8A649803BE3E73@039-SN2MPN1-023.039d.mgd.msft.net>
 <4FE39EA2.8050809@wwwdotorg.org>
 <F281D0F91ED19E4D8E63A7504E8A649803BE45CD@039-SN2MPN1-023.039d.mgd.msft.net>
 <4FE8871B.7060408@wwwdotorg.org>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803BE6A92@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> But like you said, there's no way to tell what's attached to a USB or
> SDIO port before probing it, at least if the port is at all
> user-accessible. The class driver for the host-side of the port (USB hub
> or SDIO controller) would be the one that needs to implement this, not
> the class driver for the thing that could be plugged in (WiFi or 3G
> device).
> 
Agree, I did not consider the situation that the class driver is loaded as 
module and only be loaded when that kinds of device (wifi/3g) has found
(through udev).

Maybe we have to add misc control (power/reset) for devices at sd or usb 
controller driver's probe, and those gpio are belonged to controller's.  

> > But the generic 3G and HUB devices are special, there is only one
> common driver
> > for each of them (drivers/usb/core/hub.c & drivers/serial/option.c)
