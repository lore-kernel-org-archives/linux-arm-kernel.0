From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 23:07:11 +0000
Subject: [PATCHv4 2/2] arm: Get rid of meminfo
In-Reply-To: <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
References: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
 <1392761733-32628-3-git-send-email-lauraa@codeaurora.org>
Message-ID: <20140218230710.GO21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:15:33PM -0800, Laura Abbott wrote:
> memblock is now fully integrated into the kernel and is the prefered
> method for tracking memory. Rather than reinvent the wheel with
> meminfo, migrate to using memblock directly instead of meminfo as
> an intermediate.

>  #define NR_BANKS	CONFIG_ARM_NR_BANKS
>  
> -struct membank {
> -	phys_addr_t start;
> -	phys_addr_t size;
> -	unsigned int highmem;
> -};
> -
> -struct meminfo {
> -	int nr_banks;
> -	struct membank bank[NR_BANKS];
> -};

Doesn't this make NR_BANKS (and CONFIG_ARM_NR_BANKS) unused?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
