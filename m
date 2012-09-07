From: Elen.Song@atmel.com (Song, Elen)
Date: Fri, 7 Sep 2012 09:59:17 +0000
Subject: DMA: get data count of descriptor in dmaengine
Message-ID: <E8F7C03B253D5640818937FAAE6B175C39CD07A7@penmbx02>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All:

	When I am developing using dma for uart receive, I found a problem.
	I use a cyclic dma transfer and set descriptor transfer size to lk, 
	only receive 1k bytes(descriptor transfer done) that will call an interrupt.

	If I receive 1 byte, there will happened nothing except my peripherals have timeout function. 
	Fortunately, I got timeout function in uart peripheral, in timeout handler, I can receive data from uart.
	But I do not know how many data I have receive, so there should be a count register in dma.

	I found the count register but I do not found correlative api in dmaengine, I think we should add one.
	Even during a single or multi buffer transfer, knowing how many data has been transfer in current descriptor is necessary.
	Through that, we will not lose a data.

	So there should be an api to get current descriptor receive data count.
	Or we could get current descriptor status , the status with count value?

	I submit an patch to retrieve descriptor data transfer size.
	We use this to get data count .
	We use Atmel dma, but it could be a common demand.
  
FYI & Best Regards
Elen Song
