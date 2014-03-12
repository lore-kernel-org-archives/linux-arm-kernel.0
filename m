From: yibin.gong@freescale.com (Yibin Gong)
Date: Wed, 12 Mar 2014 01:41:41 +0000
Subject: Freescale PFUZE100 PMIC
In-Reply-To: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
References: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
Message-ID: <4fc2f7234ca047bca85893b3da86f940@BLUPR03MB036.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,
	I'm little confused by your print log  and dts setting about I2C: 
>From your print log "pfuze100-regulator 0-0008:" we can know this i2c device pfuze should be connected in i2c1. But in your dts setting, you put pfuze in i2c2. Please make sure which i2c interface connected with pfuze and make correct setting in dts.

-----Original Message-----
From: John Tobias [mailto:john.tobias.ph at gmail.com] 
Sent: Wednesday, March 12, 2014 8:41 AM
To: <linux-arm-kernel@lists.infradead.org>; Gong Yibin-B38343; Shawn Guo
Subject: Freescale PFUZE100 PMIC

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


Is there anything that I forgot?. I tried to use the i2cget in userspace and I was able to communicate it to the device.

Regards,

john
