From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Dec 2009 20:33:19 +0000
Subject: dma_cache_maint_contiguous should be patched asdma_cache_maint do
In-Reply-To: <SNT109-W606545835EAEDC6CE7A542A78C0@phx.gbl>
References: <1260524165.3109.3.camel@pc1117.cambridge.arm.com>
	<SNT109-W606545835EAEDC6CE7A542A78C0@phx.gbl>
Message-ID: <20091216203319.GB17935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 11, 2009 at 12:32:06PM +0000, mkl lin wrote:
> 
> >> BTW, read performance drops from 64MBps to 44MBps on my platform.
> > Is this compared to the IPI patch or to the UP (maxcpus=1) version?
> > You can try placing a "pld [r0, #32] before the new ldr/str so that it
> > fetches the next cache line while the loop is dealing with the current
> > one.
> 
> I have redo all the tests again.
> 
> Linux 2.6.31.1
> pcie sata adapter,?ahci.c
> read 1GB file
> 
> 1CPU:13.56/13.56/13.60 (sec) ~ 75.5MBps
> SMP+IPI:16.29/16.14/16.05 (sec) ~ 63.8MBps
> SMP+RFO/WFO:21.71/21.72/21.70 (sec) ~ 47.18MBps
> SMP+RFO/WFO/pld:21.63/21.46/21.41 (sec) ~ 47.82MBps

Out of interest, how does the 1CPU version perform when you boot with
'libata.force=pio' specified to the kernel?
