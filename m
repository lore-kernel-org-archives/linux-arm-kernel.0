From: kim.phillips@freescale.com (Kim Phillips)
Date: Tue, 5 Nov 2013 15:45:39 -0600
Subject: [PATCH v7] arm: use built-in byte swap function
In-Reply-To: <alpine.LFD.2.03.1310262235310.1951@syhkavp.arg>
References: <20130129181046.GC25415@pd.tnic>
 <20130219203115.114eab79e8d2099c6306d921@freescale.com>
 <alpine.LFD.2.03.1302192151280.6419@syhkavp.arg>
 <1361356696.13482.269.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200835380.6419@syhkavp.arg>
 <1361367842.13482.279.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302200905300.6419@syhkavp.arg>
 <1361372008.13482.280.camel@i7.infradead.org>
 <alpine.LFD.2.03.1302201040460.6419@syhkavp.arg>
 <20130220214943.9b28a5b208da9f081387c55e@freescale.com>
 <alpine.LFD.2.03.1302202327370.6419@syhkavp.arg>
 <20130221005221.15279b1372501af12c1e4f32@freescale.com>
 <alpine.LFD.2.03.1302211134160.6419@syhkavp.arg>
 <20130221203327.6558f89277468f7ffffa6506@freescale.com>
 <alpine.LFD.2.03.1302212219100.6419@syhkavp.arg>
 <20130222194032.f7b44aefa5e2723d16767a1b@freescale.com>
 <1361661654.18110.102.camel@shinybook.infradead.org>
 <20130523114654.1f273241725205c6703b2226@freescale.com>
 <alpine.LFD.2.03.1310262235310.1951@syhkavp.arg>
Message-ID: <20131105154539.571de66098b77166db039a3b@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Oct 2013 22:41:34 -0400
Nicolas Pitre <nico@fluxnic.net> wrote:

> On Thu, 23 May 2013, Kim Phillips wrote:
> 
> > Enable the compiler intrinsic for byte swapping on arch ARM.  This
> > allows the compiler to detect and be able to optimize out byte
> > swappings, and has a very modest benefit on vmlinux size (Linaro gcc
> > 4.8):
> > 
> >    text	   data	    bss	    dec	    hex	filename
> > 2840310	 123932	  61960	3026202	 2e2d1a	vmlinux-lart #orig
> > 2840152	 123932	  61960	3026044	 2e2c7c	vmlinux-lart #builtin-bswap
> > 
> > 6473120	 314840	5616016	12403976 bd4508	vmlinux-mxs #orig
> > 6472586	 314848	5616016	12403450 bd42fa	vmlinux-mxs #builtin-bswap
> > 
> > 7419872	 318372	 379556	8117800	 7bde28	vmlinux-imx_v6_v7 #orig
> > 7419170	 318364	 379556	8117090	 7bdb62	vmlinux-imx_v6_v7 #builtin-bswap
> > 
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> > Reviewed-by: Nicolas Pitre <nico@linaro.org>
> > Acked-by: David Woodhouse <David.Woodhouse@intel.com>
> 
> Did this ever go somewhere?
> 
> Russell suggested at the time to base it against a mainline kernel 
> (since it was patching files which apparently were already patched with 
> out-of-tree lz4 patches) and send it to his patch system.

I'll re-base and send it to his patch system.

Thanks,

Kim
