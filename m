From: mkl0301@gmail.com (mkl0301 at gmail.com)
Date: Sun,  9 Jan 2011 15:26:07 +0800
Subject: [PATCH v5 0/3] add CNS3xxx AHCI support
Message-ID: <1294557970-654-1-git-send-email-mkl0301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mac Lin <mkl0301@gmail.com>

v5:
 - Rename ahci_platforms.h to ahci_platform.h
 - s/pltfm/platform/ in ahci_platform.c

v4: http://www.spinics.net/lists/linux-ide/msg39852.html
 - v2 basically, which make SoC-specific changes into separate files
 - Rename module ahci_platform to ahci_platforms, into which link the ahci_platform and the SoC-specific changes
 - No rename of ahci_platform.c
 - Some cosmetic code changes since v2

v3: http://www.spinics.net/lists/arm-kernel/msg109924.html
 - Make the SoC-specific changes into ahci_platform.c directly.
 - Some cosmetic code changes
=> ahci_platform.c is less readable due to SoC-specific changes and macro

v2: http://www.spinics.net/lists/linux-ide/msg39766.html
 - Renaming ahci_platform.c to ahci_pltfm.c for linking SoC specific changes into ahci_platform, while not changing the module name.
 - Switch ahci_platform to module device table matching to add SoC specific support
 - Add CNS3xxx SoC specific AHCI support to ahci_cns3xxx.c

v1: http://www.spinics.net/lists/arm-kernel/msg106236.html
 - Add CNS3xxx SoC specific AHCI support to arch/arm/mach-cns3xxx
=> The changes depends on libahci and libata, i.e. both of them need to be built into kernel

This patchset is based on linux-2.6.37
