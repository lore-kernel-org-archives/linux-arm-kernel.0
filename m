From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 Dec 2009 19:08:27 +0000
Subject: non barrier versions of dma_map functions
In-Reply-To: <4B213B11.40308@codeaurora.org>
References: <4B204193.6050004@codeaurora.org>
	<1260437955.22188.9.camel@pc1117.cambridge.arm.com>
	<4B213B11.40308@codeaurora.org>
Message-ID: <20091210190827.GD13210@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 10:16:49AM -0800, Abhijeet Dharmapurikar wrote:
> Catalin Marinas wrote:
>> What is the direction given to dma_map_single()?
>>
> DMA_TO_DEVICE
>> If the direction is TO_DEVICE, has the buffer been dirtied before
>> calling dma_map_single()? The DSB overhead could be smaller compared to
>> the actual cache flushing.
> Yes the buffers were dirtied before calling  
> dma_map_single(...DMA_TO_DEVICE);

Well, I don't think we can extend the API like this without cross-platform
agreement.
