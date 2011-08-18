From: tixy@yxit.co.uk (Tixy)
Date: Thu, 18 Aug 2011 09:27:53 +0100
Subject: [PATCH 7/9] ARM: DMA: steal memory for DMA coherent mappings
In-Reply-To: <009101cc5cde$6dfaa660$49eff320$%szyprowski@samsung.com>
References: <1313146711-1767-1-git-send-email-m.szyprowski@samsung.com>
	<201108161626.26130.arnd@arndb.de>
	<006b01cc5cb3$dac09fa0$9041dee0$%szyprowski@samsung.com>
	<201108171428.44555.arnd@arndb.de>
	<009101cc5cde$6dfaa660$49eff320$%szyprowski@samsung.com>
Message-ID: <1313656073.2254.23.camel@computer2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-08-17 at 15:06 +0200, Marek Szyprowski wrote:
[...]
> > > Maybe for the first version a static pool with reasonably small size
> > > (like 128KiB) will be more than enough? This size can be even board
> > > depended or changed with kernel command line for systems that really
> > > needs more memory.
> > 
> > For a first version that sounds good enough. Maybe we could use a fraction
> > of the CONSISTENT_DMA_SIZE as an estimate?
> 
> Ok, good. For the initial values I will probably use 1/8 of 
> CONSISTENT_DMA_SIZE for coherent allocations. Writecombine atomic allocations
> are extremely rare and rather ARM specific. 1/32 of CONSISTENT_DMA_SIZE should
> be more than enough for them.

For people who aren't aware, we have a patch to remove the define
CONSISTENT_DMA_SIZE and replace it with a runtime call to an
initialisation function [1]. I don't believe this fundamentally changes
anything being discussed though.

-- 
Tixy

[1] http://www.spinics.net/lists/arm-kernel/msg135589.html
