From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 12:12:35 +0100
Subject: arm: at91: mach header cleanup
Message-ID: <20121107111235.GH20063@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/for-3.8-at91_header_clean

for you to fetch changes up to 75984df05d86956541795f01e62d7dc67bc522fd:

  arm: at91: move at91rm9200 rtc header in drivers/rtc (2012-11-06 20:30:52 +0800)

----------------------------------------------------------------
arm: at91: mach header cleanup

This first patch serie start the cleanup of the header in mach
by moving all the platform data to include/linux/platform_data

and move the board header and drivers header next to them

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (10):
      arm: at91: drop machine defconfig
      arm: at91: move platfarm_data to include/linux/platform_data/atmel.h
      arm: at91 move board.h to arch/arm/mach-at91
      arm: at91 move at91_aic.h to arch/arm/mach-at91
      arn: at91: move at91_tc.h to arch/arm/mach-at91
      arm: at91: move board header to arch/arm/mach-at91
      arm: at91: move at91_shdwc.h to arch/arm/mach-at91
      arm: at91: move pit define to the driver
      arm: at91: move reset controller header to arm/arm/mach-at91
      arm: at91: move at91rm9200 rtc header in drivers/rtc

 arch/arm/configs/afeb9260_defconfig                                        |  106 ------------------------------
 arch/arm/configs/cam60_defconfig                                           |  173 -------------------------------------------------
 arch/arm/configs/cpu9260_defconfig                                         |  116 ---------------------------------
 arch/arm/configs/cpu9g20_defconfig                                         |  116 ---------------------------------
 arch/arm/configs/qil-a9260_defconfig                                       |  114 --------------------------------
 arch/arm/configs/sam9_l9260_defconfig                                      |  148 ------------------------------------------
 arch/arm/configs/stamp9g20_defconfig                                       |  128 ------------------------------------
 arch/arm/configs/usb-a9260_defconfig                                       |  105 ------------------------------
 arch/arm/mach-at91/{include/mach => }/at91_aic.h                           |    0
 arch/arm/mach-at91/{include/mach => }/at91_rstc.h                          |    0
 arch/arm/mach-at91/{include/mach => }/at91_shdwc.h                         |    0
 arch/arm/mach-at91/{include/mach => }/at91_tc.h                            |    0
 arch/arm/mach-at91/at91rm9200.c                                            |    2 +-
 arch/arm/mach-at91/at91rm9200_devices.c                                    |    2 +-
 arch/arm/mach-at91/at91sam9260.c                                           |    4 +-
 arch/arm/mach-at91/at91sam9260_devices.c                                   |    2 +-
 arch/arm/mach-at91/at91sam9261.c                                           |    4 +-
 arch/arm/mach-at91/at91sam9261_devices.c                                   |    2 +-
 arch/arm/mach-at91/at91sam9263.c                                           |    4 +-
 arch/arm/mach-at91/at91sam9263_devices.c                                   |    2 +-
 arch/arm/mach-at91/at91sam926x_time.c                                      |   14 +++-
 arch/arm/mach-at91/at91sam9_alt_reset.S                                    |    2 +-
 arch/arm/mach-at91/at91sam9g45.c                                           |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c                                   |    2 +-
 arch/arm/mach-at91/at91sam9g45_reset.S                                     |    3 +-
 arch/arm/mach-at91/at91sam9n12.c                                           |    2 +-
 arch/arm/mach-at91/at91sam9rl.c                                            |    4 +-
 arch/arm/mach-at91/at91sam9rl_devices.c                                    |    2 +-
 arch/arm/mach-at91/at91sam9x5.c                                            |    2 +-
 arch/arm/mach-at91/at91x40.c                                               |    3 +-
 arch/arm/mach-at91/at91x40_time.c                                          |    3 +-
 arch/arm/mach-at91/board-1arm.c                                            |    4 +-
 arch/arm/mach-at91/board-afeb-9260v1.c                                     |    5 +-
 arch/arm/mach-at91/board-cam60.c                                           |    4 +-
 arch/arm/mach-at91/board-carmeva.c                                         |    4 +-
 arch/arm/mach-at91/board-cpu9krea.c                                        |    4 +-
 arch/arm/mach-at91/board-cpuat91.c                                         |    4 +-
 arch/arm/mach-at91/board-csb337.c                                          |    4 +-
 arch/arm/mach-at91/board-csb637.c                                          |    4 +-
 arch/arm/mach-at91/board-dt.c                                              |    5 +-
 arch/arm/mach-at91/board-eb01.c                                            |    5 +-
 arch/arm/mach-at91/board-eb9200.c                                          |    5 +-
 arch/arm/mach-at91/board-ecbat91.c                                         |    4 +-
 arch/arm/mach-at91/board-eco920.c                                          |    4 +-
 arch/arm/mach-at91/board-flexibity.c                                       |    4 +-
 arch/arm/mach-at91/board-foxg20.c                                          |    4 +-
 arch/arm/mach-at91/board-gsia18s.c                                         |    8 +--
 arch/arm/mach-at91/board-kafa.c                                            |    4 +-
 arch/arm/mach-at91/board-kb9202.c                                          |    4 +-
 arch/arm/mach-at91/board-neocore926.c                                      |    4 +-
 arch/arm/mach-at91/board-pcontrol-g20.c                                    |    6 +-
 arch/arm/mach-at91/board-picotux200.c                                      |    4 +-
 arch/arm/mach-at91/board-qil-a9260.c                                       |    6 +-
 arch/arm/mach-at91/board-rm9200dk.c                                        |    4 +-
 arch/arm/mach-at91/board-rm9200ek.c                                        |    4 +-
 arch/arm/mach-at91/board-rsi-ews.c                                         |    4 +-
 arch/arm/mach-at91/board-sam9-l9260.c                                      |    4 +-
 arch/arm/mach-at91/board-sam9260ek.c                                       |    6 +-
 arch/arm/mach-at91/board-sam9261ek.c                                       |    6 +-
 arch/arm/mach-at91/board-sam9263ek.c                                       |    6 +-
 arch/arm/mach-at91/board-sam9g20ek.c                                       |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c                                    |    6 +-
 arch/arm/mach-at91/board-sam9rlek.c                                        |    7 +-
 arch/arm/mach-at91/board-snapper9260.c                                     |    4 +-
 arch/arm/mach-at91/board-stamp9g20.c                                       |    4 +-
 arch/arm/mach-at91/board-usb-a926x.c                                       |    6 +-
 arch/arm/mach-at91/board-yl-9200.c                                         |    4 +-
 arch/arm/mach-at91/{include/mach => }/board.h                              |   55 ----------------
 arch/arm/mach-at91/{include/mach => }/gsia18s.h                            |    0
 arch/arm/mach-at91/include/mach/at91_pit.h                                 |   32 ---------
 arch/arm/mach-at91/irq.c                                                   |    2 +-
 arch/arm/mach-at91/leds.c                                                  |    2 +-
 arch/arm/mach-at91/pm.c                                                    |    6 +-
 arch/arm/mach-at91/setup.c                                                 |    2 +-
 arch/arm/mach-at91/{include/mach => }/stamp9g20.h                          |    0
 arch/avr32/mach-at32ap/include/mach/board.h                                |    7 --
 drivers/ata/pata_at91.c                                                    |    2 +-
 drivers/input/touchscreen/atmel_tsadcc.c                                   |    2 +-
 drivers/mmc/host/atmel-mci.c                                               |    2 +-
 drivers/net/can/at91_can.c                                                 |    3 +-
 drivers/net/ethernet/cadence/at91_ether.c                                  |    2 +-
 drivers/pcmcia/at91_cf.c                                                   |    2 +-
 drivers/rtc/rtc-at91rm9200.c                                               |    2 +-
 arch/arm/mach-at91/include/mach/at91_rtc.h => drivers/rtc/rtc-at91rm9200.h |    0
 drivers/rtc/rtc-at91sam9.c                                                 |    2 +-
 drivers/spi/spi-atmel.c                                                    |    2 +-
 drivers/tty/serial/atmel_serial.c                                          |    2 +-
 drivers/usb/gadget/at91_udc.c                                              |    2 +-
 drivers/usb/gadget/atmel_usba_udc.c                                        |    2 +-
 drivers/usb/host/ohci-at91.c                                               |    2 +-
 drivers/video/atmel_lcdfb.c                                                |    2 +-
 include/linux/platform_data/atmel.h                                        |   67 +++++++++++++++++++
 92 files changed, 207 insertions(+), 1231 deletions(-)
 delete mode 100644 arch/arm/configs/afeb9260_defconfig
 delete mode 100644 arch/arm/configs/cam60_defconfig
 delete mode 100644 arch/arm/configs/cpu9260_defconfig
 delete mode 100644 arch/arm/configs/cpu9g20_defconfig
 delete mode 100644 arch/arm/configs/qil-a9260_defconfig
 delete mode 100644 arch/arm/configs/sam9_l9260_defconfig
 delete mode 100644 arch/arm/configs/stamp9g20_defconfig
 delete mode 100644 arch/arm/configs/usb-a9260_defconfig
 rename arch/arm/mach-at91/{include/mach => }/at91_aic.h (100%)
 rename arch/arm/mach-at91/{include/mach => }/at91_rstc.h (100%)
 rename arch/arm/mach-at91/{include/mach => }/at91_shdwc.h (100%)
 rename arch/arm/mach-at91/{include/mach => }/at91_tc.h (100%)
 rename arch/arm/mach-at91/{include/mach => }/board.h (71%)
 rename arch/arm/mach-at91/{include/mach => }/gsia18s.h (100%)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_pit.h
 rename arch/arm/mach-at91/{include/mach => }/stamp9g20.h (100%)
 rename arch/arm/mach-at91/include/mach/at91_rtc.h => drivers/rtc/rtc-at91rm9200.h (100%)

Best Regards,
J.
