From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 15 Jan 2013 15:19:40 -0500
Subject: [PATCH v2] mm: dmapool: use provided gfp flags for all
 dma_alloc_coherent() calls
In-Reply-To: <50F5B69E.1070101@gmail.com>
References: <20121119144826.f59667b2.akpm@linux-foundation.org>
 <1353421905-3112-1-git-send-email-m.szyprowski@samsung.com>
 <50F3F289.3090402@web.de>
 <20130115165642.GA25500@titan.lakedaemon.net>
 <50F5B69E.1070101@gmail.com>
Message-ID: <20130115201940.GD25500@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 09:05:50PM +0100, Sebastian Hesselbarth wrote:
> If we look for a mem leak in one of the above drivers (including sata_mv),
> is there an easy way to keep track of allocated and freed kernel memory?

I'm inclined to think sata_mv is not the cause here, as there are many
heavy users of it without error reports.  The only thing different here
are the three usb dvb dongles.

thx,

Jason.
