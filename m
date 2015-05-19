From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 23:09:36 +0100
Subject: [RFC] arm: DMA-API contiguous cacheable memory
In-Reply-To: <CAE=W-e1qynowbccHpYntWwwZPZOMHAVXH=Yj3ukyr_X8WKwQJQ@mail.gmail.com>
References: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
 <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
 <CAE=W-e1qynowbccHpYntWwwZPZOMHAVXH=Yj3ukyr_X8WKwQJQ@mail.gmail.com>
Message-ID: <20150519220936.GL2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:05:54AM +0200, Lorenzo Nava wrote:
> Maybe my interpretation of dma_alloc_coherent() is not correct, and
> the coherency can be managed using the dma_sync_single_for_* functions
> and it doesn't require hardware mechanism.

dma_sync_single_for_* are only for use with the streaming DMA API,
where you must have already mapped the buffer using one of the
dma_map_* functions.  Anything other than that is abusing the API.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
