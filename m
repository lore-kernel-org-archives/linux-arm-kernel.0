From: broonie@kernel.org (Mark Brown)
Date: Wed, 10 Jan 2018 10:36:07 +0000
Subject: [RESEND PATCH v9 00/13] Add STM32 DFSDM support
In-Reply-To: <1515579195-12894-1-git-send-email-arnaud.pouliquen@st.com>
References: <1515579195-12894-1-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <20180110103607.GD9003@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 11:13:02AM +0100, Arnaud Pouliquen wrote:

> Jonathan's comment for you, posted for this version:
> >So Mark, over to you. I'm happy if you want to do the immutable branch once 
> >any issue you find are fixed, or I can do it. 
> >I'm just looking for acks or a pull request now.

Jonathan, this is a pretty weird way of doing things - the bulk of the
series is for IIO so I'd have expected it to go in via the IIO tree.
It's especially odd to end up with the driver which isn't a build
dependency in my tree.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/iio-asoc-sync

for you to fetch changes up to 16cbca06fa8288a4f58426fc898b141e12ee8008:

  IIO: consumer: allow to set buffer sizes (2018-01-10 10:30:14 +0000)

----------------------------------------------------------------
IIO: ST DFSDM support

This is the IIO portion of some patches adding support for the ST DFSDM
IP, it's shared with ASoC as the hardware is also used for audio.

----------------------------------------------------------------
Arnaud Pouliquen (10):
      docs: driver-api: add iio hw consumer section
      IIO: hw_consumer: add devm_iio_hw_consumer_alloc
      IIO: inkern: API for manipulating channel attributes
      IIO: Add DT bindings for sigma delta adc modulator
      IIO: ADC: add sigma delta modulator support
      IIO: add DT bindings for stm32 DFSDM filter
      IIO: ADC: add stm32 DFSDM core support
      IIO: ADC: add STM32 DFSDM sigma delta ADC support
      IIO: ADC: add stm32 DFSDM support for PDM microphone
      IIO: consumer: allow to set buffer sizes

Lars-Peter Clausen (1):
      iio: Add hardware consumer buffer support

 .../ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32      |   16 +
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |  128 +++
 Documentation/driver-api/iio/hw-consumer.rst       |   51 +
 Documentation/driver-api/iio/index.rst             |    1 +
 drivers/iio/adc/Kconfig                            |   37 +
 drivers/iio/adc/Makefile                           |    3 +
 drivers/iio/adc/sd_adc_modulator.c                 |   68 ++
 drivers/iio/adc/stm32-dfsdm-adc.c                  | 1216 ++++++++++++++++++++
 drivers/iio/adc/stm32-dfsdm-core.c                 |  309 +++++
 drivers/iio/adc/stm32-dfsdm.h                      |  310 +++++
 drivers/iio/buffer/Kconfig                         |   10 +
 drivers/iio/buffer/Makefile                        |    1 +
 drivers/iio/buffer/industrialio-buffer-cb.c        |   11 +
 drivers/iio/buffer/industrialio-hw-consumer.c      |  247 ++++
 drivers/iio/inkern.c                               |   17 +-
 include/linux/iio/adc/stm32-dfsdm-adc.h            |   18 +
 include/linux/iio/consumer.h                       |   37 +
 include/linux/iio/hw-consumer.h                    |   21 +
 include/linux/iio/iio.h                            |   28 -
 include/linux/iio/types.h                          |   28 +
 21 files changed, 2537 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dfsdm-adc-stm32
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst
 create mode 100644 drivers/iio/adc/sd_adc_modulator.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm-core.c
 create mode 100644 drivers/iio/adc/stm32-dfsdm.h
 create mode 100644 drivers/iio/buffer/industrialio-hw-consumer.c
 create mode 100644 include/linux/iio/adc/stm32-dfsdm-adc.h
 create mode 100644 include/linux/iio/hw-consumer.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180110/96f4bc67/attachment.sig>
