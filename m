From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 18 Feb 2014 18:49:04 -0500 (EST)
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <20140218230710.GO21483@n2100.arm.linux.org.uk>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
 <20140218230710.GO21483@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1402181848140.17677@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Feb 2014, Russell King - ARM Linux wrote:

> On Tue, Feb 18, 2014 at 02:15:33PM -0800, Laura Abbott wrote:
> > memblock is now fully integrated into the kernel and is the prefered
> > method for tracking memory. Rather than reinvent the wheel with
> > meminfo, migrate to using memblock directly instead of meminfo as
> > an intermediate.
> 
> >  #define NR_BANKS	CONFIG_ARM_NR_BANKS
> >  
> > -struct membank {
> > -	phys_addr_t start;
> > -	phys_addr_t size;
> > -	unsigned int highmem;
> > -};
> > -
> > -struct meminfo {
> > -	int nr_banks;
> > -	struct membank bank[NR_BANKS];
> > -};
> 
> Doesn't this make NR_BANKS (and CONFIG_ARM_NR_BANKS) unused?

Still used in atag_to_fdt.c but I just sent a patch moving it there.


Nicolas
