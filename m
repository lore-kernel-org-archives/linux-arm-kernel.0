From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Dec 2013 10:58:51 -0600
Subject: [PATCH v7 00/14] Add power management support for mxs phy
In-Reply-To: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20131223165851.GG28679@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 20, 2013 at 03:51:56PM +0800, Peter Chen wrote:
> Hi Felipe & Shawn,
> 
> The serial adds power management support for MXS PHY, it includes:
> 
> - Add one PHY API .set_wakeup, and related API implementation at mxs phy driver
> - misc changes and bug fixes for mxs phy to support low power mode and wakeup.
> 
> It is based on Greg's usb-next, 3.13-rc1.

I can't take all patches through my tree because it lacks acked-by's.
But I'm afraid there are dependencies with your patches.

> Peter Chen (14):
>   usb: doc: phy-mxs: Add more compatible strings

ok

>   usb: phy-mxs: Add platform judgement code

ok

>   usb: phy-mxs: Add auto clock and power setting

ok

>   usb: doc: phy-mxs: update binding for adding anatop phandle

ok

>   ARM: dts: imx6: add anatop phandle for usbphy

misses Ack

>   usb: phy-mxs: Add anatop regmap

depends on previous

>   usb: phy-mxs: change description of usb device speed

ok

>   usb: phy-mxs: Enable IC fixes for related SoCs

ok

>   ARM: dts: imx: add mxs phy controller id

misses Ack

>   usb: phy-mxs: add controller id

depends on previous

>   usb: phy: Add set_wakeup API

ok

>   usb: phy-mxs: Add implementation of set_wakeup

ok

>   usb: phy-mxs: Add system suspend/resume API

ok

>   usb: phy-mxs: Add sync time after controller clear phcd

ok

Considering the dependencies, I think it's safer to defer this patchset
until next merge window.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131223/e0fd752f/attachment.sig>
