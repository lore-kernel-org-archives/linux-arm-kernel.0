From: muni.anda@gmail.com (muni anda)
Date: Mon, 27 Feb 2012 21:01:45 -0800
Subject: I2C device suspend ordering w.r.t to other SOC drivers
Message-ID: <CAPcvF7u_PdQG3n519Xesron3nujnJ7dVS3TuT2wB6jygbO__iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a requirement that an I2C device needs to be suspended after
all other SOC drivers are suspended (expect the I2C bus driver
though). I2C driver framework is written so that after the I2C bus
driver is loaded, I2C peripheral drivers are registered (based off
i2c_register_board_info() tables). By this time all the other platform
devices are registered. This design put the I2C devices in the end of
the registration order and that will result in suspending the device
first, which is not what I want.

Any way around this?

- Muni
