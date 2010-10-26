From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 26 Oct 2010 15:58:41 +0300
Subject: Is ep93xx support broken in linux-next?
In-Reply-To: <20101026125050.GB15333@gw.healthdatacare.com>
References: <1288094199.2098.26.camel@r60e>
	<20101026125050.GB15333@gw.healthdatacare.com>
Message-ID: <20101026125841.GC15333@gw.healthdatacare.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 26, 2010 at 03:50:51PM +0300, Mika Westerberg wrote:
[...]
>  
>  /*
> + *	flush_icache_all()
> + *
> + *	Unconditionally clean and invalidate the entire icache.
> + */
> +ENTRY(fa_flush_icache_all)
> +	mov	r0, #0
> +	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache

Obviously the register should be r0 instead of ip.

MW
