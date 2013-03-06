From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Mar 2013 18:46:21 +0000
Subject: [PATCH v11 9/9] usb: chipidea: udc: fix the oops when plugs in
 usb cable after rmmod gadget
In-Reply-To: <1362563800-16673-10-git-send-email-peter.chen@freescale.com>
References: <1362563800-16673-1-git-send-email-peter.chen@freescale.com>
 <1362563800-16673-10-git-send-email-peter.chen@freescale.com>
Message-ID: <20130306184621.GX17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:56:40PM +0800, Peter Chen wrote:
> root at freescale ~$ ci_hdrc ci_hdrc.0: Connected to host
> Unable to handle kernel paging request at virtual address 7f01171c
> pgd = 80004000
> [7f01171c] *pgd=4fa1e811, *pte=00000000, *ppte=00000000
> Internal error: Oops: 7 [#1] SMP ARM
> Modules linked in: f_acm libcomposite u_serial [last unloaded: g_serial]
> CPU: 0    Not tainted  (3.8.0-rc5+ #221)
> 	PC is at _gadget_stop_activity+0xbc/0x128
> 	LR is at ep_fifo_flush+0x68/0xa0


Why much of the oops dump indented?
