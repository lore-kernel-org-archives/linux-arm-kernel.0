From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 1 Jun 2015 08:34:26 +0900
Subject: [PATCH v9 0/3] ARM: mediatek: Add driver for Mediatek I2C
In-Reply-To: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
References: <1432198410-6576-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <20150531233424.GA17308@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 04:53:27PM +0800, Eddie Huang wrote:
> This series is for Mediatek SoCs I2C controller common bus driver.
> 
> Earlier MTK SoC (for example, MT6589, MT8135) I2C HW has some limitations.
> New generation SoC like MT8173 fix following limitations:
> 
> 1. Only support one i2c_msg number. One exception is WRRD (write then read)
> mode. WRRD can have two i2c_msg numbers.
> 
> 2. Mediatek I2C controller support WRRD(write then read) mode, in WRRD
> mode the Repeat Start will be issued between 2 messages.
> In this driver if 2 messages is first write then read, the driver will
> combine 2 messages using Write-Read mode so the RS will be issued between
> the 2 messages.
> 
> 3. The max transfer data length is 255 in one message. In WRRD mode, the
> max data length of second msg is 31.
> 
> MT8135 and MT6589 can control I2C pins on PMIC(MT6397) by setting the i2c
> registers in MT8135 side. In this case, driver should set OFFSET_PATH_DIR
> bit first, the operation on other registers are still the same.
> For now MT6589/MT8135 support this, MT6577/MT6595/MT8127 do not support.
> For example, If want to use I2C4/5/6 pins on MT8135 just need to enable
> the pinmux, else if want to use I2C pins on PMIC(MT6397) need to add
> "mediatek,have-pmic" property in the .dts file of each platform.
> 
> This driver is based on 4.1-rc1.

Applied to for-next, thanks! Especially for being an early adaptor of
the quirk framework and for keeping at this during this thorough review
from all sides. Thanks to the reviewers as well!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150601/d87a9ad8/attachment.sig>
