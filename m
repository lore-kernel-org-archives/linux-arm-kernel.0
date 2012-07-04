From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 4 Jul 2012 16:55:53 -0300
Subject: Clock problems in i.MX27 Visstrim M10 (linux-3.5-rc5).
In-Reply-To: <CAOMZO5A0YXcZOB+ov+dD0MVJr0XSr=Ufg5snGDLvZ9=GyK=xMw@mail.gmail.com>
References: <CACKLOr0z13sMQhb14YpDp7UtwfhVoqRAMOJCA+geapq=Lh7VuQ@mail.gmail.com>
 <CAOMZO5CeGKJ6kERaCkNE0Cpy2X78CUN_-au5Q+cCtLLjtNXMDg@mail.gmail.com>
 <CACKLOr1oeci84Fs7HTRD2Myie8zjKExA15mxM3z7dkq8QfvDmg@mail.gmail.com>
 <CAOMZO5Bdpe43wSAS-D34LzVA9gAKwGTjsw_1f3iPizVsWJW7kw@mail.gmail.com>
 <CACKLOr1OYmoWXCU=Q_0O1H5jYcAGXO11ji6d_j7SjyaLZuygAA@mail.gmail.com>
 <CAOMZO5CLV6TuQUTzYUSvoi6apNUtSLhkbh8Jj3onAnc99TWxWg@mail.gmail.com>
 <CAOMZO5A0YXcZOB+ov+dD0MVJr0XSr=Ufg5snGDLvZ9=GyK=xMw@mail.gmail.com>
Message-ID: <CAOMZO5BwraSVyW8SZjoN19gy-eZ2tXXPRT879PdAOu38Yf-z0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2012 at 3:23 PM, Fabio Estevam <festevam@gmail.com> wrote:

> ,and I get the following on probe:
>
> soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
> mx2-camera mx2-camera.0: Camera driver attached to camera 0
> ov2640 0-0030: Product ID error fb:fb
> mx2-camera mx2-camera.0: Camera driver detached from camera 0
> mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 665000
>
> Looks like an i2c error when trying to read the ov2640 ID.

Just for comparison, here is the log from a 3.4.4 kernel:

soc-camera-pdrv soc-camera-pdrv.0: Probing soc-camera-pdrv.0
mx2-camera mx2-camera.0: Camera driver attached to camera 0
ov2640 0-0030: ov2640 Product ID 26:42 Manufacturer ID 7f:a2
i2c i2c-0: OV2640 Probed
mx2-camera mx2-camera.0: Camera driver detached from camera 0
mx2-camera mx2-camera.0: MX2 Camera (CSI) driver probed, clock frequency: 443333
Driver for 1-wire Dallas network protocol

i2detetc also sees 0x30 (camera address) on 3.4.4:

root at freescale /$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] Y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: 10 -- -- -- -- -- -- -- -- -- -- -- -- 1d -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: UU -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- 76 --

,but on 3.5-rc5 (or linux-next) the camera address is not detected via
i2cdetect.

Wolfram,

Have you seen any issues lately with mx27 i2c?

Regards,

Fabio Estevam
