From: denis.ciocca@st.com (Denis CIOCCA)
Date: Thu, 21 Nov 2013 12:41:24 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <528DF164.8060009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime, everyone,

only one point: it's possible to use the same names with DT? (using _ 
instead of -)
Why only for i2c?

Thanks,
Denis

> Hi everyone,
>
> This is an attempt at adding the DT probing to the st_sensors
> accelerometers and gyroscopes.
>
> It's somewhat hackish, because the core actively checks for the value
> of the device at probe time, and DT probing generates a quite
> different name.
>
> I first tried to turn the function st_sensors_check_device_support the
> other way around, with the "leaf" providing the sensor structure, and
> the function checking that it's consistent with the WAI stored in the
> sensor. However, it turned to be a quite intrusive change, so I'm
> sending the easiest one, to try to get some feedback :)
>
> Thanks!
> Maxime
>
> Maxime Ripard (3):
>    iio: accel: Add device tree probing for STMicro accelerometers
>    iio: accel: Add device tree probing for STMicro gyroscopes
>    ARM: cfa10057: Add the accelerometer and gyroscope to the device tree
>
>   .../devicetree/bindings/iio/accel/st_accel_i2c.txt | 22 +++++++++++++++
>   .../devicetree/bindings/iio/gyro/st_gyro_i2c.txt   | 20 +++++++++++++
>   arch/arm/boot/dts/imx28-cfa10057.dts               | 13 +++++++++
>   drivers/iio/accel/st_accel_i2c.c                   | 33 ++++++++++++++++++++++
>   drivers/iio/gyro/st_gyro_i2c.c                     | 31 ++++++++++++++++++++
>   5 files changed, 119 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/iio/accel/st_accel_i2c.txt
>   create mode 100644 Documentation/devicetree/bindings/iio/gyro/st_gyro_i2c.txt
>
