From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 16:32:12 +0200
Subject: [PATCH 2/2] ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard
In-Reply-To: <CACRpkdbZjB0Bpb_j4txUHyTNi1xkQ=z1fQpUrfh=aktfnSmcjg@mail.gmail.com>
References: <1473342103-30554-1-git-send-email-linus.walleij@linaro.org>
 <7249221.7eA5nsROLb@wuerfel>
 <CACRpkdbZjB0Bpb_j4txUHyTNi1xkQ=z1fQpUrfh=aktfnSmcjg@mail.gmail.com>
Message-ID: <4412227.YknKLSc6om@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 4:03:38 PM CEST Linus Walleij wrote:
> 
> Yes, but that is not the driver enabled by this patch. This is
> compatible = "smsc,lan9221", "smsc,lan9115";
> which has the driver smsc911x.c, but the problem
> you're pointing to is in the driver smc911x.c.
> or rather its header file.
> 
> One letter difference I know, the naming of these
> drivers is not human-friendly. I make the mistake
> all the time.

Ah, right. I also see now that the last user of smc911x was removed
from the kernel in January 2015 with a521422ea4ae ("ARM: shmobile:
mackerel: Remove Legacy C board code"), and everything is now using
the smsc911x driver, so I suppose we can finally delete the old one
as planned originally:

commit fd9abb3d97c2ab883e4732ec1214fe64190236e7
Author: Steve Glendinning <steve.glendinning@smsc.com>
Date:   Wed Nov 5 00:35:37 2008 +0000

    SMSC LAN911x and LAN921x vendor driver
    
    Attached is a driver for SMSC's LAN911x and LAN921x families of embedded
    ethernet controllers.
    
    There is an existing smc911x driver in the tree; this is intended to
    replace it.  Dustin McIntire (the author of the smc911x driver) has
    expressed his support for switching to this driver.
    
    This driver contains workarounds for all known hardware issues, and has
    been tested on all flavours of the chip on multiple architectures.
    
    This driver now uses phylib, so this patch also adds support for the
    device's internal phy
    
    Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
    Signed-off-by: Bahadir Balban <Bahadir.Balban@arm.com>
    Signed-off-by: Dustin Mcintire <dustin@sensoria.com>
    Signed-off-by: Bill Gatliff <bgat@billgatliff.com>
    Signed-off-by: Jeff Garzik <jgarzik@redhat.com>

	Arnd
