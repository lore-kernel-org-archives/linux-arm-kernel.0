From: hector.oron@gmail.com (Hector Oron)
Date: Wed, 31 Aug 2011 13:57:06 +0100
Subject: [PATCH V7 1/5] AHCI Add the AHCI SATA feature on the MX53
	platforms
In-Reply-To: <CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
References: <1314698171-7937-1-git-send-email-richard.zhu@linaro.org>
	<CAODfWeEm8bkySXxb1qopbH1VMu-V+33k5x+0+qjABzesT0amOA@mail.gmail.com>
	<CAJNCFV+XFGEba1J2dXDa4YVwqduAPV5y=5JYEXAZ0uv+S60vvw@mail.gmail.com>
Message-ID: <CAODfWeEueF45_yvPV5Zxbva6K2gEfKZbY2qoqySYFPZWnSgLsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

2011/8/31 Richard Zhu <richard.zhu@linaro.org>:
> Hi Hector:
> Thanks for your help to tests these patches.

Note I rebased this patches against 'imx-features' branch on Sascha's tree.
I am noticing some obscure (to me) messages from kernel:

[    6.874694] Adding 9767516k swap on /dev/sda3.  Priority:-1
extents:1 across:9767516k
[    7.073106] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[    7.708399] ata1.00: exception Emask 0x12 SAct 0x3 SErr 0x1280500
action 0x6 frozen
[    7.716219] ata1.00: irq_stat 0x08000000, interface fatal error
[    7.722216] ata1: SError: { UnrecovData Proto 10B8B BadCRC TrStaTrns }
[    7.728780] ata1.00: failed command: READ FPDMA QUEUED
[    7.733995] ata1.00: cmd 60/00:00:f2:11:32/01:00:00:00:00/40 tag 0
ncq 131072 in
[    7.734002]          res 40/00:04:f2:11:32/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[    7.749468] ata1.00: status: { DRDY }
[    7.753176] ata1.00: failed command: READ FPDMA QUEUED
[    7.758356] ata1.00: cmd 60/18:08:c2:14:32/00:00:00:00:00/40 tag 1
ncq 12288 in
[    7.758363]          res 40/00:04:f2:11:32/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[    7.773739] ata1.00: status: { DRDY }
[    7.777448] ata1: hard resetting link
[    8.750427] ata1: softreset failed (device not ready)
[    8.755551] ata1: applying PMP SRST workaround and retrying
[    8.960435] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    8.981938] ata1.00: configured for UDMA/133
[    8.986535] ata1: EH complete
[   12.147912] eth0: Freescale FEC PHY driver [Generic PHY]
(mii_bus:phy_addr=1:00, irq=-1)
[   12.521870] ata1.00: exception Emask 0x12 SAct 0xf SErr 0x800500
action 0x6 frozen
[   12.529518] ata1.00: irq_stat 0x08000000, interface fatal error
[   12.535546] ata1: SError: { UnrecovData Proto LinkSeq }
[   12.540851] ata1.00: failed command: READ FPDMA QUEUED
[   12.546039] ata1.00: cmd 60/00:00:a2:19:2c/01:00:00:00:00/40 tag 0
ncq 131072 in
[   12.546046]          res 40/00:14:7a:aa:2c/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[   12.561519] ata1.00: status: { DRDY }
[   12.565209] ata1.00: failed command: READ FPDMA QUEUED
[   12.570419] ata1.00: cmd 60/00:08:1a:e9:2c/01:00:00:00:00/40 tag 1
ncq 131072 in
[   12.570426]          res 40/00:14:7a:aa:2c/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[   12.585890] ata1.00: status: { DRDY }
[   12.589578] ata1.00: failed command: READ FPDMA QUEUED
[   12.594776] ata1.00: cmd 60/00:10:7a:aa:2c/01:00:00:00:00/40 tag 2
ncq 131072 in
[   12.594783]          res 40/00:14:7a:aa:2c/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[   12.610240] ata1.00: status: { DRDY }
[   12.613945] ata1.00: failed command: READ FPDMA QUEUED
[   12.619118] ata1.00: cmd 60/e0:18:1a:10:2c/00:00:00:00:00/40 tag 3
ncq 114688 in
[   12.619125]          res 40/00:14:7a:aa:2c/00:00:00:00:00/40 Emask
0x12 (ATA bus error)
[   12.634583] ata1.00: status: { DRDY }
[   12.638292] ata1: hard resetting link
[   13.790424] ata1: softreset failed (device not ready)
[   13.795543] ata1: applying PMP SRST workaround and retrying
[   14.000437] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   14.021749] ata1.00: configured for UDMA/133
[   14.026836] ata1: EH complete
[   14.140774] PHY: 1:00 - Link is Up - 100/Full


Best regards,
-- 
?H?ctor Or?n ?-.. . -... .. .- -. ? -.. . ...- . .-.. --- .--. . .-.
