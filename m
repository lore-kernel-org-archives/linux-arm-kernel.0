From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 16:55:53 -0800
Subject: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock lookup
In-Reply-To: <1385851897-23475-10-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-10-git-send-email-gsi@denx.de>
Message-ID: <20131205005553.GC21377@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 11:51:29PM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the "ipg" clock item for register access as well
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the difference since v4 of this patch is that v4 took the 'mclk'
> and 'ipg' clock items in reverse order, and thus potentially obfuscated
> the adjusted name for 'mclk' -- the updated version of the patch is
> identical in content but cleaner diff-wise

That's fine:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
