From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 21 Jan 2011 14:59:35 -0500 (EST)
Subject: [PATCH] arm: Improve MMC performance on Versatile Express
In-Reply-To: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
References: <1295618352-26432-1-git-send-email-pawel.moll@arm.com>
Message-ID: <alpine.LFD.2.00.1101211456200.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Jan 2011, Pawel Moll wrote:

> VE suffers from serious problem with MMC transfers - low performance,
> errors when other IO peripherals (especially USB) are used at the
> same time etc.
> 
> It all boils down to the MMC controller short FIFO and - in result -
> timing constrains. The most problematic case - USB driver hogging
> CPU and MMC FIFO under/overruns in the result - can be mitigated on
> SMP system by distributing interrupts handling for these peripherals
> between cores.

Wouldn't the ultimate solution be to simply use FIQs to service the MMC FIFO?


Nicolas
