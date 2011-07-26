From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jul 2011 14:12:57 +0100
Subject: [PATCH V4 03/14] DMA: PL330: Support DMA_SLAVE_CONFIG command
In-Reply-To: <003c01cc4b94$82e39e20$88aada60$%kim@samsung.com>
References: <1311557312-26107-1-git-send-email-boojin.kim@samsung.com>
	<1311557312-26107-4-git-send-email-boojin.kim@samsung.com>
	<1311589617.27357.3.camel@vkoul-mobl4>
	<002401cc4ac9$97737570$c65a6050$%kim@samsung.com>
	<1311601700.8206.7.camel@vkoul-mobl4>
	<003c01cc4b94$82e39e20$88aada60$%kim@samsung.com>
Message-ID: <20110726131257.GA1655@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2011 at 10:04:10PM +0900, Boojin Kim wrote:
> Vinod Koul Wrote:
> > I meant you should use proper fields for passing info, which in this
> > case would be dst_maxburst for specifying destination burst sizes
> I think the naming seems to make confusion.
> 'Peri->burst_sz' on this code means the width of fifo in bytes of the peri. 
> It's same with the meaning 'xxx_addr_width'. So, I think it's proper usage.
> 'peri->burst_sz' is passed to PL330 HW. PL330 HW wants to get the power of 2 
> based the fifo width for it.
> For example, If fifo width is 8 bytes, PL330 HW should get '3' for it.
> And I will modify code to consider xxx_maxburst.

IMHO from your description above, peri->burst_sz is misnamed.  Please
add a comment at this location to say something like:

	/* peri->burst_sz is the peripheral fifo width */

to explain this.

Thanks.
