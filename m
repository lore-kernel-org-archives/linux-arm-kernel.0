From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 9 Jan 2015 14:19:27 -0800
Subject: [PATCH 1/5] tty/serial: at91: use correct type for
 dma_sync_*_for_cpu() and dma_sync_*_for_device()
In-Reply-To: <54AFF037.1000004@atmel.com>
References: <cover.1418131298.git.cyrille.pitchen@atmel.com>
 <830a2b33ab0226405dc310c8a6d43731bf4ca8f9.1418131298.git.cyrille.pitchen@atmel.com>
 <54AFF037.1000004@atmel.com>
Message-ID: <20150109221927.GA19100@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 04:13:59PM +0100, Nicolas Ferre wrote:
> Le 09/12/2014 14:31, Cyrille Pitchen a ?crit :
> > dma_sync_*_for_cpu() and dma_sync_*_for_device() use 'enum dma_data_direction',
> > not 'enum dma_transfer_direction'
> > 
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> 
> Sure:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Here it's difficult to add a "stable" tag as the error was introduced by
> several different patches.

So that means it's not ok for older kernels?  That doesn't make sense...
