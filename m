From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 11 Mar 2014 19:00:28 -0700
Subject: Freescale PFUZE100 PMIC
In-Reply-To: <4fc2f7234ca047bca85893b3da86f940@BLUPR03MB036.namprd03.prod.outlook.com>
References: <CACUGKYN4uaT0xn4fMCqVNXeKYSf_WP+GkpkAb6vagQeGFdJUmw@mail.gmail.com>
 <4fc2f7234ca047bca85893b3da86f940@BLUPR03MB036.namprd03.prod.outlook.com>
Message-ID: <CACUGKYM_HTEZU8a+g2iZyYOyEq6i=0_G-b1UzhmZd9wKR0Q+OA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yibin,

Sorry for the confusion (I forgot to mention). I was using a custom
board where the PMIC is connected to i2c2. The i2c2 bus has 3 slave
devices, the two were running Ok. I was running 400000 freq. clock and
tried the 100000 as well.

Regards,

john


On Tue, Mar 11, 2014 at 6:41 PM, Yibin Gong <yibin.gong@freescale.com> wrote:
> Hi John,
>         I'm little confused by your print log  and dts setting about I2C:
> From your print log "pfuze100-regulator 0-0008:" we can know this i2c device pfuze should be connected in i2c1. But in your dts setting, you put pfuze in i2c2. Please make sure which i2c interface connected with pfuze and make correct setting in dts.
>
> -----Original Message-----
> From: John Tobias [mailto:john.tobias.ph at gmail.com]
> Sent: Wednesday, March 12, 2014 8:41 AM
> To: <linux-arm-kernel@lists.infradead.org>; Gong Yibin-B38343; Shawn Guo
> Subject: Freescale PFUZE100 PMIC
>
> Hi All,
>
> I was trying to enable the PFUZE100 regulator driver
> (pfuze100-regulator) on linux 3.13.0. The PMIC is connected to the
> i2c2 bus.
>
> &i2c2 {
>    .....
>    pmic: pfuze100 at 08 {
>           compatible = "fsl,pfuze100";
>           reg = <0x08>;
>
>           regulators {
>                  ......
>           };
>    };
> }
>
> After loading the driver, I was getting an error:
> pfuze100-regulator 0-0008: unrecognized pfuze chip ID!
>
> Then, I printed the return value of i2c_transfer function and got -5.
>
>
> Is there anything that I forgot?. I tried to use the i2cget in userspace and I was able to communicate it to the device.
>
> Regards,
>
> john
>
>
