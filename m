From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 13:48:27 +0000
Subject: [Q] block / zynq: DMA bouncing
In-Reply-To: <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
References: <Pine.LNX.4.64.1401271549280.23931@axis700.grange>
 <20140127170230.GQ15937@n2100.arm.linux.org.uk> <52E69B4E.5010604@monstr.eu>
 <20140127175231.GU15937@n2100.arm.linux.org.uk> <52E69E1E.3020202@monstr.eu>
 <Pine.LNX.4.64.1401281420580.2714@axis700.grange>
Message-ID: <20140128134827.GK15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 02:28:28PM +0100, Guennadi Liakhovetski wrote:
> +static void __init zynq_memory_init(void)
> +{
> +	/*
> +	 * Reserve the 0-0x4000 addresses (before page tables and kernel)
> +	 * which can't be used for DMA
> +	 */
> +	if (!__pa(PAGE_OFFSET))
> +		memblock_reserve(0, 0x4000);

Or maybe this:

	memblock_reserve(__pa(PAGE_OFFSET), __pa(swapper_pg_dir));

since that's actually what you mean here.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
