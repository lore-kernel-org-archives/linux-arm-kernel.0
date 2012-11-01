From: nbowler@elliptictech.com (Nick Bowler)
Date: Thu, 1 Nov 2012 14:39:21 -0400
Subject: [PATCH v2] ARM: zynq: Allow UART1 to be used as DEBUG_LL console.
In-Reply-To: <508FB9B1.5060404@monstr.eu>
References: <1351534769-22155-1-git-send-email-nbowler@elliptictech.com>
 <508FB9B1.5060404@monstr.eu>
Message-ID: <20121101183921.GA32744@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-10-30 12:27 +0100, Michal Simek wrote:
> On 10/29/2012 07:19 PM, Nick Bowler wrote:
> > +#if IS_ENABLED(CONFIG_DEBUG_ZYNQ_UART1)
> > +#	define LL_UART_PADDR	UART1_PHYS
> > +#	define LL_UART_VADDR	UART_VIRT
> > +#else
> > +#	define LL_UART_PADDR	UART0_PHYS
> > +#	define LL_UART_VADDR	UART_VIRT
> > +#endif
> 
> Probably no reason to setup LL_UART_VADDR on two lines.
> It is enough to set it up once.
> 
> MINOR: It is just my personal preference to use different coding style.
> 
> #if IS_ENABLED(CONFIG_DEBUG_ZYNQ_UART1)
> # define LL_UART_PADDR	UART1_PHYS
> #else
> # define LL_UART_PADDR	UART0_PHYS
> #endif
> 
> #define LL_UART_VADDR	UART_VIRT

I have no strong feeling either way, so I will send v3 with these
changes.

Thanks,
-- 
Nick Bowler, Elliptic Technologies (http://www.elliptictech.com/)
