From: andre@bluewatersys.com (Andre Renaud)
Date: Mon, 30 May 2011 13:52:13 +1200
Subject: Freescale i.mx25 SDIO/Libertas issue
Message-ID: <4DE2F84D.8080907@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
I am trying to use a Wi2Wi 802.11b/g (W2CBW009S) module attached to an
i.MX25 cpu, specifically the i.MX25 PDK from freescale, although I've
also tried it on a DeviceSolutions Topaz i.MX25. However it is unable to
fully load the driver, leaving me with the following in the logs:
[   30.149097] libertas_sdio mmc0:0001:1: (unregistered net_device):
command 0x00a9 timed out
[   30.153759] libertas_sdio mmc0:0001:1: (unregistered net_device):
Timeout submitting command 0x00a9
[   30.158843] libertas_sdio mmc0:0001:1: (unregistered net_device):
PREP_CMD: command 0x00a9 failed: -110
[   30.164126] libertas_sdio mmc0:0001:1: (unregistered net_device):
CMD_FUNC_INIT cmd failed
This wifi chip is based around the Marvell 8688 core.

I have also tried using an 8686 device, and in that case it is unable to
even complete loading the firmware, failing with the following:
[   14.753132] libertas_sdio: Firmware req_size: 17
[   14.755713] libertas_sdio: failed to load firmware: -5
[   14.759272] libertas_sdio: probe of mmc0:0001:1 failed with error -5
Note: I added the 'req_size: ' debugging message in

Has anyone successfully used the i.MX25 SDIO controller with anything
other than straight MMC cards (which seem to work fine in the setup that
I have)?

Regards,
Andre Renaud
