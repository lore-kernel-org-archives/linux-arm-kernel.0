From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:12:47 +0200
Subject: [PATCHv4 08/20] usb: host: xhci-plat: add support for the
 Armada 375/38x XHCI controllers
In-Reply-To: <536AEFA0.3070806@renesas.com>
References: <1399470746-2948-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1399470746-2948-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <536AEFA0.3070806@renesas.com>
Message-ID: <20140511201247.182d5f48@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shimoda, Yoshihiro,

On Thu, 8 May 2014 11:44:48 +0900, Shimoda, Yoshihiro wrote:

> > +#ifndef __LINUX_XHCI_MVEBU_H
> > +#define __LINUX_XHCI_MVEBU_H
> > +#if IS_ENABLED(CONFIG_USB_XHCI_MVEBU)
> > +int xhci_mvebu_mbus_init_quirk(struct platform_device *pdev);
> > +#else
> > +static inline int xhci_mvebu_mbus_init_quirk(struct device dev)
> 
> I could not compile this code when I disabled CONFIG_USB_XHCI_MVEBU:
> 	incompatible type for argument 1 of 'xhci_mvebu_mbus_init_quirk'.
> 
> So, the "struct device dev" should be changed to "struct platform_device *pdev".

Ah, yes, correct, thanks! Will fix in v5.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
