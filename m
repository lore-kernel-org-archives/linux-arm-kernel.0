From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 23:34:44 +0100
Subject: [RFC] arm: DMA-API contiguous cacheable memory
In-Reply-To: <2882347.Nj1Dq9Wlqh@wuerfel>
References: <CAE=W-e24oDH5RZfPftRg_xYBiG+b9Sj09vpyay9EwqOo9cVX1w@mail.gmail.com>
 <20150519163436.GZ21251@e104818-lin.cambridge.arm.com>
 <CAE=W-e1qynowbccHpYntWwwZPZOMHAVXH=Yj3ukyr_X8WKwQJQ@mail.gmail.com>
 <2882347.Nj1Dq9Wlqh@wuerfel>
Message-ID: <20150519223444.GO2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 12:14:48AM +0200, Arnd Bergmann wrote:
> With that memory, you should be able to use the normal streaming
> API (dma_sync_single_for_*).

Wrong, as I've pointed out previously.  The only memory which you're
allowed to sync is with memory which has been mapped with a dma_map_*()
function.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
