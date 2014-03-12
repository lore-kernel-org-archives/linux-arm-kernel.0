From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 11 Mar 2014 17:41:22 -0700
Subject: Freescale PFUZE100 PMIC
Message-ID: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

I was trying to enable the PFUZE100 regulator driver
(pfuze100-regulator) on linux 3.13.0. The PMIC is connected to the
i2c2 bus.

&i2c2 {
   .....
   pmic: pfuze100 at 08 {
          compatible = "fsl,pfuze100";
          reg = <0x08>;

          regulators {
                 ......
          };
   };
}

After loading the driver, I was getting an error:
pfuze100-regulator 0-0008: unrecognized pfuze chip ID!

Then, I printed the return value of i2c_transfer function and got -5.


Is there anything that I forgot?. I tried to use the i2cget in
userspace and I was able to communicate it to the device.

Regards,

john
