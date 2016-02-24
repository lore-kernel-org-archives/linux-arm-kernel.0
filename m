From: kernel@tekno-soft.it (Roberto Fichera)
Date: Wed, 24 Feb 2016 11:12:19 +0100
Subject: iMX6q PCIe phy link never came up on kernel v4.4.x
Message-ID: <56CD8203.8050209@tekno-soft.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi There,

Working on a custom iMX6q board I'm getting a PCIe phy link never came up, even if uboot detect
everything ok. My DTS is enabling PCIe with

&pcie {
    pinctrl-names = "default";
    pinctrl-0 = <&pinctrl_pcie_reset>;
    reset-gpio = <&gpio7 12 0>;
    status = "okay";
};

The PCIe is connected to a PCIe-to-PCI TI XIO2001, so I'd like to know if there is any other special
setup to do in order to get it to work on a v4.4.x kernel.

Any idea?

Thanks in advance,
Roberto Fichera.

U-Boot 2014.04-imx_v2014.04_3.14.38_6qp_beta+g6e9282c (Feb 15 2016 - 10:02:31)

CPU:   Freescale i.MX6Q rev1.5 at 792 MHz
CPU:   Temperature 35 C, calibration data: 0x5664d569
Reset cause: POR
Board: Janas iMX6Q (ID:e315c064140749d4)
I2C:   ready
DRAM:  2 GiB
MMC:   FSL_SDHC: 0, FSL_SDHC: 1
*** Warning - bad CRC, using default environment

  00:01.0     - 16c3:abcd - Bridge device
   01:00.0    - 104c:8240 - Bridge device
    02:04.0   - 1397:08b4 - Network controller
In:    serial
Out:   serial
Err:   serial
Found PFUZE100! deviceid=10,revid=21
mmc1(part 0) is current device
Net:   FEC [PRIME]
Warning: failed to set MAC address

Normal Boot
....
....
[    0.236141] PCI host bridge /soc/pcie at 0x01000000 ranges:
[    0.236162]   No bus range found for /soc/pcie at 0x01000000, using [bus 00-ff]
[    0.236213]   err 0x01f00000..0x01f7ffff -> 0x01f00000
[    0.236250]    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.236330]   MEM 0x01000000..0x01efffff -> 0x01000000
-->>> [    0.546690] imx6q-pcie 1ffc000.pcie: phy link never came up
[    0.547263] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    0.547287] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.547304] pci_bus 0000:00: root bus resource [??? 0x01f00000-0x01f7ffff flags 0x0]
[    0.547321] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.547335] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01efffff]
[    0.548608] PCI: bus0: Fast back to back transfers disabled
[    0.548950] PCI: bus1: Fast back to back transfers enabled
[    0.549107] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
[    0.549137] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
[    0.549159] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.549945] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
...
