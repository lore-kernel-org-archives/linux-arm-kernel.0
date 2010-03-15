From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 07:52:14 -0500
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9DC239.90407@st.com>
References: <4B9DB823.1040809@st.com>	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com>
Message-ID: <4B9E2D7E.1020702@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shiraz HASHIM wrote:
>
> I think the problem is we cannot change the standard drivers (already in the
> mainline). So if the standard driver doesn't support this in its probe, then
> how should we manage this?
>
> Further these configurations are board dependent, so I think driver must be
> independent of this.
>   

What I think you really want is for your board-specific code (or some
helper code elsewhere in your mach-* directory) to do the pin
assignments, and the drivers just assume that the pins are all right. 
That's the approach used in OMAP2 and AT91, among others, and it seems
to work out just fine.

If you assume that the driver "just knows" what the multiplexer settings
need to be, then sooner or later that same peripheral gets used in a
different SoC and that assumption has to get tossed out.  That's
happening some with the AT91 drivers that can also be used on AVR32
chips.  Best to avoid that extra work by putting the platform-specific
knowledge where it belongs: in the platform-specific code.



b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
