From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Sep 2013 13:49:01 +0100
Subject: [PATCH v3 00/38] iio: ST clean-ups and new sensor support
Message-ID: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Sorry for the continued development and resubmission. I won't write
anymore patches now. At least until these have been accepted.

This patch-set includes a few clean-ups surrounding error handling and
non-mandatory functionality along with regulator support and the addition
of a new pressure/temperature sensor (LPS001WP) and extended support for
a new magnetometer sensor (LSM303DLH).

Everything has been tested with Device Tree.
  
v2:
 - Rebased onto Linux -next as requested by Jonathan
 - Reworked clean-up patch to address Jonathan's concerns
 - Added binding document (inc regulators)
 - Extended regulator support in the driver
 - Re-worked Data Ready pin handling

v3:
 - Standardise sensor names: <model>_<sensor-type>
 - Added error handling clean-ups
 - More binding documents; for magn, accel and gyro
 - Message on successful sensor bring-up; for press, magn, accel and gyro
 - More device enablement for ux500 by way of CONFIGs
 - New neat reorder/grouping of patches 

 Documentation/devicetree/bindings/iio/accel/lsm303dlh.txt        |  21 ++++++++
 Documentation/devicetree/bindings/iio/gyro/l3g4200d.txt          |  21 ++++++++
 Documentation/devicetree/bindings/iio/magnetometer/lsm303dlh.txt |  21 ++++++++
 Documentation/devicetree/bindings/iio/pressure/lps001wp.txt      |  21 ++++++++
 arch/arm/boot/dts/ste-dbx5x0.dtsi                                |   5 --
 arch/arm/boot/dts/ste-snowball.dts                               |  34 ++++++++++++
 arch/arm/configs/u8500_defconfig                                 |   5 ++
 drivers/iio/accel/st_accel.h                                     |   4 +-
 drivers/iio/accel/st_accel_core.c                                |  28 +++++-----
 drivers/iio/common/st_sensors/st_sensors_core.c                  |  79 +++++++++++++++-------------
 drivers/iio/gyro/st_gyro.h                                       |   8 +--
 drivers/iio/gyro/st_gyro_core.c                                  |  24 +++++----
 drivers/iio/magnetometer/st_magn.h                               |   3 +-
 drivers/iio/magnetometer/st_magn_core.c                          |  27 +++++-----
 drivers/iio/pressure/st_pressure.h                               |   3 +-
 drivers/iio/pressure/st_pressure_core.c                          | 303 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 drivers/iio/pressure/st_pressure_i2c.c                           |   1 +
 include/linux/iio/common/st_sensors.h                            |   6 +++
 18 files changed, 453 insertions(+), 161 deletions(-)
