From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 28 Aug 2011 19:57:35 -0600 (MDT)
Subject: How to handle named resources with DT?
In-Reply-To: <alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<201108261741.29850.arnd@arndb.de>
	<20110827143736.GA10182@yookeroo.fritz.box>
	<5595208.OB5dBohxQP@wuerfel>
	<20110828083934.GA4254@yookeroo.fritz.box>
	<alpine.DEB.2.00.1108281100150.23968@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1108281952400.18667@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

one case that I forgot to mention:

On Sun, 28 Aug 2011, Paul Walmsley wrote:

> Several upstream device drivers get their DMA request line IDs from the 
> device data format[14][15][16].  But more drivers should be doing this 
> than currently are[17]:
> 
> - the device driver author may have hardcoded the DMA request line ID, 
>   assuming it would never change
> 
> - DMA could be broken on the device due to hardware bugs, so it is unused
> 
> - the driver author may just never have gotten around to implementing DMA, 
>   or was reassigned to another project, or couldn't figure it out
> 
> - the device may have its own internal DMA controller logic, so support 
>   for an external DMA controller was simply never added

- the driver may be using software-initiated DMA, which doesn't use a 
  DMA request line, nor does it rely on the device to start or stop DMA.
  Instead, the CPU reprograms the DMA controller when the driver receives 
  an interrupt


- Paul
