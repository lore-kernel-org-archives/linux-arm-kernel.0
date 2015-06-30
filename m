From: balbi@ti.com (Felipe Balbi)
Date: Tue, 30 Jun 2015 01:10:05 -0500
Subject: [PATCH] phy: phy-mxs-usb: suspend to RAM causes NULL pointer
 dereference
In-Reply-To: <5592297B.4080103@i2se.com>
References: <1434343020-29604-1-git-send-email-stefan.wahren@i2se.com>
 <5592297B.4080103@i2se.com>
Message-ID: <20150630061005.GD32758@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 07:30:35AM +0200, Stefan Wahren wrote:
> Am 15.06.2015 um 06:37 schrieb Stefan Wahren:
> > Triggering suspend to RAM via sysfs on a i.MX28 causes a NULL pointer
> > dereference. This patch avoids the oops in mxs_phy_get_vbus_status()
> > by aborting since there is no syscon available.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Fixes: efdbd3a5d6e ("usb: phy: mxs: do not set PWD.RXPWD1PT1 for low speed connection")
> > CC: <stable@vger.kernel.org> # 4.0
> > Acked-by: Peter Chen <peter.chen@freescale.com>
> 
> Just a gentle ping

it's in my queue, but -rc1 wasn't tagged yet, was it ? In a hurry for
some reason ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150630/22885890/attachment.sig>
