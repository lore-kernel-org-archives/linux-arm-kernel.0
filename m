From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 3 Mar 2014 08:58:01 +0100
Subject: nand pmecc crash detected
In-Reply-To: <5310B108.8040800@celad.com>
References: <5310B108.8040800@celad.com>
Message-ID: <20140303075801.GJ17250@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 04:53:44PM +0100, Herve Codina wrote:
> Hi,
> 
> I am using an sam5d35 and its pmecc nand ecc controller.
> 
> In barebox, using similar atmel_nand.c the system crashes.
> 
> The problem was a call to chip->ecc.hwctl from nand_write_subpage_hwecc
> (nand_base.c) when we write a sub page.
> 
> chip->ecc.hwctl function is not set when we are using PMECC controller.
> 
> As a workaround, i set NAND_NO_SUBPAGE_WRITE for PMECC controller in
> order to disable sub page access in nand_write_page.
> 
> I think we can have the same problem in Linux. I do not performed
> subpage nand writes from Linux but i made the following patch according
> to my Barebox defect.
> 
> Here after are my patches (same modification) for 1st my local Barebox
> and 2nd my local Linux :

Applied (for barebox ;), thanks

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
