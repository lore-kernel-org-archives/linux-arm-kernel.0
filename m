From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 12 Mar 2012 08:51:07 +0100
Subject: [PATCH] mtd/gpmi : fix the wrong DMA command.
In-Reply-To: <1331518938-24047-1-git-send-email-b32955@freescale.com>
References: <1331518938-24047-1-git-send-email-b32955@freescale.com>
Message-ID: <20120312075107.GB3928@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 10:22:18AM +0800, Huang Shijie wrote:
> The last DMA command of ECC read page is used to disable the BCH module.
> But the original code missed to set the pio[2] which is used to set the
> GPMI_HW_GPMI_ECCCTRL register. fix it now.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Thanks! What does happen because of this bug? Additional checksum errors? I
haven't seen many on MX28 IIRC, so I wonder.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120312/fbb120b6/attachment-0001.sig>
