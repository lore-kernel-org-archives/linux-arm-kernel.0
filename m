From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 12 Aug 2013 11:27:52 -0700
Subject: [PATCH v4 23/31] serial: mpc512x: setup the PSC FIFO clock as well
In-Reply-To: <1375821851-31609-24-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-24-git-send-email-gsi@denx.de>
Message-ID: <20130812182752.GC20233@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 10:44:03PM +0200, Gerhard Sittig wrote:
> prepare and enable the FIFO clock upon PSC FIFO initialization,
> check for and propagage errors when enabling the PSC FIFO clock,
> disable and unprepare the FIFO clock upon PSC FIFO uninitialization,
> remove the pre-enable workaround from the platform's clock driver
> 
> devm_{get,put}_clk() doesn't apply here, as the SoC provides a
> single FIFO component which is shared among several PSC components,
> thus the FIFO isn't associated with a device (while the PSCs are)
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
