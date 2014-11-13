From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 13 Nov 2014 19:31:22 +0100
Subject: [PATCH v2 0/3] ARM: mediatek: Add driver for Mediatek I2C
 controller
In-Reply-To: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
References: <1415078977-18374-1-git-send-email-xudong.chen@mediatek.com>
Message-ID: <20141113183122.GH1275@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> MTK I2C HW has some limitation.
> 1. If the i2c_msg number is more than one, STOP will be issued instead of
> RS(Repeat Start) between each message.
> 
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
> Ex: W/R/R, driver will combine first W/R and then R.
> 
> 3. Due to HW limitation, in this version the max transfer data length is 255
> in one message.

This looks to me more like an SMBUS controller instead of I2C. Maybe you
should populate smbus_xfer rather than master_xfer?

> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side.

I still didn't get this, even after reading the mail thread of old
series. Can someone maybe draw me a nice ASCII picture showing the setup
which is going on here?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/3c345ed1/attachment.sig>
