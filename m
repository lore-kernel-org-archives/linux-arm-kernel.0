From: balbi@ti.com (Felipe Balbi)
Date: Thu, 30 Jul 2015 11:25:27 -0500
Subject: [PATCH] drivers/usb/: Simplify return statements
In-Reply-To: <20150730131337.GA2715@alcatraz>
References: <20150730131337.GA2715@alcatraz>
Message-ID: <20150730162527.GL18246@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 30, 2015 at 01:13:42PM +0000, Karajgaonkar, Saurabh (S.) wrote:
> From: Saurabh Karajgaonkar <skarajga@visteon.com>
> 
> This patch is created using simple_return.cocci coccinelle script.
> It replaces the redundant instances where variables are assigned
> return value from functions and then used in return statements.
> 
> Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>

do you mind splitting this per-driver ? That makes it a lot easier for
different maintainers to take their part. For example, I would take
drivers/usb/phy/* and drivers/usb/musb/*

Alan Stern would handle drivers/usb/host/[uoe]hci*.[ch]

Mathias Nyman, driver/usb/host/xhci*.[ch]

and so on. Thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150730/7a4ff866/attachment.sig>
