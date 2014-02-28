From: gregkh@linuxfoundation.org ('gregkh@linuxfoundation.org')
Date: Fri, 28 Feb 2014 08:33:04 -0800
Subject: change kmalloc into vmalloc for large memory allocations
In-Reply-To: <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D102844605F38C@CNBJMBX05.corpusers.net>
 <53104ECA.4010702@freescale.com>
 <35FD53F367049845BC99AC72306C23D102844605F38D@CNBJMBX05.corpusers.net>
Message-ID: <20140228163304.GA15614@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 05:20:08PM +0800, Wang, Yalin wrote:
> Hi  
> 
> 
> Yeah,  
> Dma buffer must be allocated by kmalloc,
> 
> But the modules I list should can all be changed to use
> vmalloc, because the buffer is only used by software,
> Not by any hardware .

Are you sure about that?  The USB gadget driver needs DMA memory from
what I can tell, have you tried your change out on a system that does
not allow the USB controller to access non-DMA memory?

And I agree with Steve, just fix the individual drivers, don't do a
"hidden" change of where the memory is allocated from, that's not a good
idea and will cause problems later.

greg k-h
