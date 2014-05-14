From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 14 May 2014 18:27:25 +0200
Subject: [PATCH] i2c/nuc900: fix ancient build error
In-Reply-To: <1399560990-1402858-11-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-11-git-send-email-arnd@arndb.de>
Message-ID: <20140514162725.GG12911@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 08, 2014 at 04:56:22PM +0200, Arnd Bergmann wrote:
> As far as I can tell, this driver must have produced this error
> for as long as it has been merged into the mainline kernel, but
> it was never part of the normal build tests:
> 
> drivers/i2c/busses/i2c-nuc900.c: In function 'nuc900_i2c_probe':
> drivers/i2c/busses/i2c-nuc900.c:601:17: error: request for member 'apbfreq' in something not a structure or union
>   ret = (i2c->clk.apbfreq)/(pdata->bus_freq * 5) - 1;
>                  ^
> 
> This is an attempt to get the driver to build and possibly
> work correctly, although I do wonder whether we should just
> remove it, as it has clearly never worked.

I'd go for removing. For this platform, the last patch which was not a
generic cleanup seems to be from late 2011?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/0bdd9c84/attachment.sig>
