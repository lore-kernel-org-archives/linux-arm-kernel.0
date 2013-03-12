From: balbi@ti.com (Felipe Balbi)
Date: Tue, 12 Mar 2013 11:46:49 +0200
Subject: [RFC PATCH 2/3] usb: udc: delete the vbus indicator at
 individual driver
In-Reply-To: <1363078999-7361-2-git-send-email-peter.chen@freescale.com>
References: <1363078999-7361-1-git-send-email-peter.chen@freescale.com>
 <1363078999-7361-2-git-send-email-peter.chen@freescale.com>
Message-ID: <20130312094649.GC15163@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 05:03:18PM +0800, Peter Chen wrote:
> Let the common struct usb_gadget own it.
> 
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> CC: Li Yang <leoli@freescale.com>
> CC: Roland Stigge <stigge@antcom.de>
> CC: Yu Xu <yuxu@marvell.com>
> CC: Chao Xie <chao.xie@marvell.com>
> CC: Eric Miao <eric.y.miao@gmail.com>
> CC: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

you need to split this patch, should be something like below:

for_each_driver() {
	initialize gadget->vbus_active (don't remove private method)
}

add vbus_active support to udc-core

for_each_driver() {
	remove driver's private vbus_active method
}

you need one patch per driver so it's easy to review and ack.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130312/8cb76081/attachment.sig>
