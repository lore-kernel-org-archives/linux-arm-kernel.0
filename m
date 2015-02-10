From: balbi@ti.com (Felipe Balbi)
Date: Tue, 10 Feb 2015 08:49:25 -0600
Subject: [PATCH v3 4/5] usb: phy: load usb phy earlier
In-Reply-To: <20150210070424.GC32709@shlinux2>
References: <20150210070424.GC32709@shlinux2>
Message-ID: <20150210144925.GD16711@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 10, 2015 at 03:04:28PM +0800, Peter Chen wrote:
> This patch does not belong to phy, so, doesn't need to
> add phy in subject, meanwhile, please add GregKH as TO list,
> he is the right one to queue this patch.
> 
> Reply-To: 
> In-Reply-To: <1423554627-694-5-git-send-email-zhangfei.gao@linaro.org>
> 
> On Tue, Feb 10, 2015 at 03:50:26PM +0800, Zhangfei Gao wrote:
> > Since phy is definitely used in usb controller, load the phy
> > earlier to make boot time shorter.
> > 
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Acked-by: Peter Chen <peter.chen@freescale.com>

NAK, make sure there are no such dependencies with your controller
driver. They should know how to defer probing if their resources aren't
available yet.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150210/6c13a06b/attachment.sig>
