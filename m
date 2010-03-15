From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Mar 2010 16:58:09 +0000
Subject: QUERY: How to handle SOC Configuration (Peripheral
	Multiplexing) in linux
In-Reply-To: <4B9E5A29.1090407@st.com>
References: <4B9DB823.1040809@st.com>
	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com> <4B9E2D7E.1020702@billgatliff.com>
	<4B9E5A29.1090407@st.com>
Message-ID: <20100315165809.GG700@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 15, 2010 at 05:02:49PM +0100, Armando VISCONTI wrote:
>>
>> What I think you really want is for your board-specific code (or some
>> helper code elsewhere in your mach-* directory) to do the pin
>> assignments, and the drivers just assume that the pins are all right.  
>> That's the approach used in OMAP2 and AT91, among others, and it seems
>> to work out just fine.
>>   
>
> Bill,
>
> What you and Russell are saying is a little bit different from what I  
> got since
> now, with people suggesting to implement a single linux image which is
> then configured at runtime thru (for example) bootargs.

No, we're suggesting the same thing.

> Now you both are saying that compile time options are better, correct?

No.  We're suggesting that you put platform specific details in their own
.c file like everything else does on ARM and use the mechanisms already
provided for supporting multi-platform kernels.

It's actually extremely difficult to avoid the multi-platform support.

Eg, see arch/arm/mach-pxa/palm*.c - PXA kernels can support all those
Palm platforms from one kernel image.

The compile time options concern whether to include support for a
particular board.  However, the ultimate decision about how to configure
the PXA chip is made at run time.
