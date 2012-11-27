From: teemu.keskinarkaus@crosscontrol.com (Teemu Keskinarkaus)
Date: Tue, 27 Nov 2012 08:34:44 +0000
Subject: Libertas/SDIO(8686) and Freescale mx5
Message-ID: <E25187DA1B6BED42A600EBDF4CE04518021F9AB9C2@MAIL-UA.ccs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I did find some Libertas stuff on mailing list archive, but nothing related to my case so here goes.

We have mx53 based hardware running Linux (2.6.35.3) and there is also Marvel 8686 WLAN-module connected to SDIO.  I've compiled Libertas drivers to Linux and also sd/mmc drivers. 

One problem is that system boots from SD-card so if I enable MMC debug there will be lots of debug prints just from SD-card access. 

SD-card is connected on first sd/mmc-interface and the WLAN-module on second. I've added both busses on board config and I can see them via debugfs.  Now when I load the Libertas modules (also the _sdio one) there is no traffic on second mmc-bus. I think I need somehow tie the libertas_sdio to mmc1, but I'm not sure how to do that. This is probably trivial thing, but I couldn't find any documentation about this.  So, does anyone know how to do that?

Once I get that working I can start sorting other things. I already have firmware files in place in /lib/firmware/libertas

Btw. If mxc_mmc - module is needed, it cannot be loaded since it will give error that symbol mxc_mmc_force_detect is already defined and it's defined in mx_sdhci - driver.

-Teemu K.
