From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Mon, 04 Mar 2013 18:51:10 +0100
Subject: LVDS (LDB) driver for i.MX53 IPU
Message-ID: <5134DF0E.7010402@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

I need to add LVDS support to your staging imx/drm driver.

First of all are there any patches floating around to do that? (a search 
of the mailing list didn't turn up any).

 From a hardware point of view it looks quite simple (just one register 
to configure) but unfortunately that register is in the IOMUXC region.

That means that if I write a new platform driver similar to 
drivers/staging/imx-drm/parallel-display.c (with a new DT node pointing 
to the reg) the request_resource() will fail since it will already be 
claimed by the iomuxc driver.

The only solutions I can think of are:
1) Add exported function to the iomuxc driver to get the register
or
2) Directly ioremap() the address

Both of these sound horrible.

Do you have any suggestions?

I guess the generic question I'm asking is how to handle the case where 
unrelated drivers require access to the same memory regions?

Regards,

Martin
