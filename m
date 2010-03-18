From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 14:19:30 +0000
Subject: Highmem issues with MMC filesystem
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
References: <037201cac5d7$6c5b8c60$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003170946250.31128@xanadu.home>
	<043e01cac5df$c3ec1b90$LocalHost@wipblrx0099946>
	<alpine.LFD.2.00.1003171050160.31128@xanadu.home>
	<20100318092352.GD8267@n2100.arm.linux.org.uk>
	<c70ff3ad1003180415x58e29baaj9b8b77e6378cb0cb@mail.gmail.com>
	<20100318112453.GA19544@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1003180904440.31128@xanadu.home>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C489CB4A@dbde02.ent.ti.com>
Message-ID: <20100318141930.GF19544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 07:00:06PM +0530, Shilimkar, Santosh wrote:
> Or could it be that there is appropriate cacheflush happening but data gets
> stuck in CPU writebuffers instead of reaching to main memory. In this case
> too DMA won't see the contents and a barrier (dsb) is necessary to ensure
> that write buffer is drained before DMA takes over the buffer.

That would imply that the data on the device is becoming corrupted.

What exactly is the problem that we're discussing?  Is it that the data
on the block device is becoming corrupted, or is the data being read off
the block device corrupted?
