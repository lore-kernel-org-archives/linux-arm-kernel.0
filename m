From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 4 Apr 2017 22:32:50 +0200
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
In-Reply-To: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
References: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
Message-ID: <20170404203249.GA4416@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bryan,

On Tue, Apr 04, 2017 at 08:28:34PM +0000, Bryan Evenson wrote:
> 
> With the 3.10 kernel, I had to use the TX DMA only.  For some reason 
> receive wouldn't work for me with the DMA.  Now with the latest on the 
> linux-4.4-at91 branch I can't use the TX DMA.  The data is transmitted 
> correctly out the USART (verified on a receiving device), but then the 
> return message is not received.  I verified the same results when both 
> RX&TX DMA was enabled and only when the TX DMA was enabled.  If I use 
> only the RX DMA, everything works fine if I have only one device on 
> the RS-485 port.  As soon as I daisy chain more than one device on an 
> RS-485 port, then I start dropping messages.  If I turn off both the 
> RX and TX DMA, then all data transfers work just fine.
> 
> I'd like to get both TX and RX DMA working for all three RS-485 ports.  
> Anyone have any suggestions for what to look at to get DMA working 
> while in RS-485 mode?  I'm planning to start trying a git bisect, but 
> given these are different branches I wasn't sure how well that was 
> going to work.

Did you check that you didn't run out of available DMA channels on each 
DMA controller ? AT91SAM9G25 unfortunately doesn't have much of them.

Sylvain
