From: marex@denx.de (Marek Vasut)
Date: Mon, 20 Jul 2015 00:12:13 +0200
Subject: [PATCH V4 RFC 2/3] nvmem: add driver for ocotp in i.MX23 and
 i.MX28
In-Reply-To: <1437343499-16422-3-git-send-email-stefan.wahren@i2se.com>
References: <1437343499-16422-1-git-send-email-stefan.wahren@i2se.com>
 <1437343499-16422-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201507200012.13608.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 20, 2015 at 12:04:58 AM, Stefan Wahren wrote:
> This patch brings read-only support for the On-Chip OTP cells
> in the i.MX23 and i.MX28 processor. The driver implements the
> new NVMEM provider API.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

How come this driver isn't doing any manipulation with the VDDIO
voltage -- or did I miss that? I seem to remember that the VDDIO
had to be lowered to 2.8V before the fuses could be programmed
and restored to 3.3V afterward. See for example recent mainline
u-boot, drivers/misc/mxs_ocotp.c .

Best regards,
Marek Vasut
