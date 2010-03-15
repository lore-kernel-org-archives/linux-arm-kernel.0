From: armando.visconti@st.com (Armando VISCONTI)
Date: Mon, 15 Mar 2010 17:02:49 +0100
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9E2D7E.1020702@billgatliff.com>
References: <4B9DB823.1040809@st.com>	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com> <4B9E2D7E.1020702@billgatliff.com>
Message-ID: <4B9E5A29.1090407@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> What I think you really want is for your board-specific code (or some
> helper code elsewhere in your mach-* directory) to do the pin
> assignments, and the drivers just assume that the pins are all right. 
> That's the approach used in OMAP2 and AT91, among others, and it seems
> to work out just fine.
>   

Bill,

What you and Russell are saying is a little bit different from what I 
got since
now, with people suggesting to implement a single linux image which is
then configured at runtime thru (for example) bootargs.

Now you both are saying that compile time options are better, correct?

So, we have two choices:

1. Stay as it is, which means to use menuconfig options.
2. Provide board-specific code in the mach-spear directory.

You are suggesting 2, which also seems to be the pin_config stuff
inside mach-pxa. Am I aligned?

If so, I think we can proceed in the suggested way.
It looks to me very clean.


> If you assume that the driver "just knows" what the multiplexer settings
> need to be, then sooner or later that same peripheral gets used in a
> different SoC and that assumption has to get tossed out.  That's
> happening some with the AT91 drivers that can also be used on AVR32
> chips.  Best to avoid that extra work by putting the platform-specific
> knowledge where it belongs: in the platform-specific code.
>   
Correct.

I think this has never been our intention anyway.
The drivers shouldn't know anything about platform-specific stuff, as
they are expected to work across multiple platform.

Thx,
Arm





-- 
-- "Every step appears to be the unavoidable consequence of the
-- preceding one." (A. Einstein) 
-- 
Armando Visconti                  Mobile: (+39) 346 8879146
Senior SW Engineer                Fax:    (+39) 02 93519290
CPG                               Work:   (+39) 02 93519683
Computer System Division          e-mail: armando.visconti at st.com
ST Microelectronics               TINA:   051  4683
                                    
 
