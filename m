From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 4 Dec 2013 16:55:21 -0800
Subject: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as well
In-Reply-To: <1385851897-23475-11-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-11-git-send-email-gsi@denx.de>
Message-ID: <20131205005521.GA21377@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 11:51:30PM +0100, Gerhard Sittig wrote:
> prepare and enable the FIFO clock upon PSC FIFO initialization,
> check for and propagage errors when enabling the PSC FIFO clock,
> disable and unprepare the FIFO clock upon PSC FIFO uninitialization
> 
> devm_{get,put}_clk() doesn't apply here, as the SoC provides a
> single FIFO component which is shared among several PSC components,
> thus the FIFO isn't associated with a device (while the PSCs are)
> 
> provide a fallback clock lookup approach in case the OF based clock
> lookup for the PSC FIFO fails, this allows for successful operation in
> the presence of an outdated device tree which lacks clock specs
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial at vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the addition since v4 is the clk_get_sys() call for the 'ipg'
> clock item (backwards compat for device trees w/o clock specs)

That's fine, my ACK still stands.

thanks,

greg k-h
