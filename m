From: anemo@mba.ocn.ne.jp (Atsushi Nemoto)
Date: Wed, 06 Jul 2011 22:41:01 +0900 (JST)
Subject: PAD_CTL_DVS bit on MX51
Message-ID: <20110706.224101.253170565.anemo@mba.ocn.ne.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have question about MX51 pin settings.
There is PAD_CTL_DVS definition in iomux-v3.h:

#define PAD_CTL_DVS			(1 << 13)

I'm not sure what "DVS" mean, but I suppose this is HVE bit in MX51
reference manual.

HVE: High / Low Output Voltage Range. This bit selects the output
     voltage mode for XXX.
    0 High output voltage mode
    1 Low output voltage mode

Currently there are several usages of this definition in iomux-mx51.h.
MX51_SDHCI_PAD_CTRL is used for SD pins, and MX51_PAD_CTRL_4 and
MX51_PAD_CTRL_5 are used for FEC pins.

If I understand correctly the MX51 EVK hardware, FEC pins are 1.8V and
SD pins are 3.15V, so it is strange that all those pins use
PAD_CTL_DVS.

Is MX51_SDHCI_PAD_CTRL (MX51 EVK SD pins) really needs PAD_CTL_DVS
bit?
I want to know expected pin settings for these signals.


And also, I know there are following definitions in u-boot iomux.h:
	PAD_CTL_DRV_VOT_LOW = 0x0 << 13, /* Low voltage mode */
	PAD_CTL_DRV_VOT_HIGH = 0x1 << 13,/* High voltage mode */
These symbols are reversed from reference manual.
It seems there are some confusion about meaning of the bit...

Any comments from MX51 experts are welcome.  Thanks.

---
Atsushi Nemoto
