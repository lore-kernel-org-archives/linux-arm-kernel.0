From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 13 Feb 2010 08:28:23 +0100
Subject: i2c-imx: Autoprobe of eeproms
In-Reply-To: <4B75D317.7040801@vmlinux.org>
References: <4B75D317.7040801@vmlinux.org>
Message-ID: <20100213072823.GA3220@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mattias,

On Fri, Feb 12, 2010 at 11:15:51PM +0100, Mattias Walstrom wrote:

> I have tried to get autoprobe of eeproms to work on a custom freescale
> mx27-board, and i found out that the i2c-imx driver was missing the
> following, is there a reason for this, most other i2c-bus drivers seems
> to have it?

Yes. Autoprobing on I2C is not favoured (can have side-effects) with embedded
platforms, so the proper way is to declare the eeprom as board-info or
instantiate it at runtime.

Check Documentation/i2c/instantiating-devices for further info.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100213/0ed54079/attachment.sig>
