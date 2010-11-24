From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Nov 2010 15:34:48 +0100
Subject: rm9200: update
In-Reply-To: <20101120095906.GD4216@game.jcrosoft.org>
References: <20101120095906.GD4216@game.jcrosoft.org>
Message-ID: <20101124143448.GH11909@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	version 2

	replace 
	at91/picotux200: fix warning: 'picotux200_mmc_data' defined but not used
	by
	at91/picotux200: remove commenting usb device and dataflash support

	fix comments
	and add
	at91/board-yl-9200: fix typo in video support

The following changes since commit b86db4744230c94e480de56f1b7f31117edbf193:

  Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2010-11-19 19:46:45 -0800)

are available in the git repository at:

  git://git.jcrosoft.org/linux-2.6.git rm9200

Jean-Christophe PLAGNIOL-VILLARD (7):
      at91: Convert remaining boards to new-style UART initialization
      at91rm9200dk: fix warning: 'dk_mmc_data' defined but not used
      at91rm9200ek: fix warning: 'ek_mmc_data' defined but not used
      at91: rename rm9200ek and rm9200dk board file name
      at91/picotux200: remove commenting usb device and dataflash support
      atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'
      at91/board-yl-9200: fix typo in video support

 arch/arm/mach-at91/Makefile                        |    4 +-
 arch/arm/mach-at91/at91rm9200_devices.c            |   45 -----------------
 arch/arm/mach-at91/board-1arm.c                    |   26 +++++-----
 arch/arm/mach-at91/board-kafa.c                    |   21 +++-----
 arch/arm/mach-at91/board-picotux200.c              |   53 ++++----------------
 .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    4 +-
 .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    4 +-
 arch/arm/mach-at91/board-yl-9200.c                 |    2 +-
 arch/arm/mach-at91/include/mach/board.h            |    6 --
 drivers/spi/atmel_spi.c                            |    6 ++-
 10 files changed, 45 insertions(+), 126 deletions(-)
 rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (98%)
 rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (98%)

Best Regards,
J.
On 10:59 Sat 20 Nov     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	this patch update some issues found on rm9200
> 	during the test of the rm9200 defconfig consolidation
> 
> The following changes since commit b86db4744230c94e480de56f1b7f31117edbf193:
> 
>   Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2010-11-19 19:46:45 -0800)
> 
> are available in the git repository at:
> 
>   git://git.jcrosoft.org/linux-2.6.git rm9200
> 
> Jean-Christophe PLAGNIOL-VILLARD (6):
>       at91: Convert remaining boards to new-style UART initialization
>       at91rm9200dk: fix warning: 'dk_mmc_data' defined but not used
>       at91rm9200ek: fix warning: 'ek_mmc_data' defined but not used
>       at91/picotux200: fix warning: 'picotux200_mmc_data' defined but not used
>       at91: rename rm9200ek and rm9200dk board file name
>       atmel_spi: fix warning In function 'atmel_spi_dma_map_xfer'
> 
>  arch/arm/mach-at91/Makefile                        |    4 +-
>  arch/arm/mach-at91/at91rm9200_devices.c            |   45 --------------------
>  arch/arm/mach-at91/board-1arm.c                    |   26 ++++++------
>  arch/arm/mach-at91/board-kafa.c                    |   21 ++++------
>  arch/arm/mach-at91/board-picotux200.c              |   25 +++++------
>  .../arm/mach-at91/{board-dk.c => board-rm9200dk.c} |    2 +
>  .../arm/mach-at91/{board-ek.c => board-rm9200ek.c} |    2 +
>  arch/arm/mach-at91/include/mach/board.h            |    6 ---
>  drivers/spi/atmel_spi.c                            |    4 +-
>  9 files changed, 42 insertions(+), 93 deletions(-)
>  rename arch/arm/mach-at91/{board-dk.c => board-rm9200dk.c} (99%)
>  rename arch/arm/mach-at91/{board-ek.c => board-rm9200ek.c} (99%)
> 
> Best Regards,
> J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
