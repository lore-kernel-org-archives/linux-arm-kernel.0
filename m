From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 May 2015 15:42:52 +0200
Subject: [PATCH] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <55658209.4000904@gmail.com>
References: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
 <555D1706.7040309@gmail.com> <20150525090100.GC29660@kwain>
 <55658209.4000904@gmail.com>
Message-ID: <20150527134252.GG27202@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 10:36:25AM +0200, Sebastian Hesselbarth wrote:
> On 25.05.2015 11:01, Antoine Tenart wrote:
> >On Thu, May 21, 2015 at 01:21:42AM +0200, Sebastian Hesselbarth wrote:
> >>On 20.05.2015 14:53, Antoine Tenart wrote:
> >>>+
> >>>+				spi0_pmux: spi0-pmux {
> >>>+					groups = "G8", "G9", "G10", "G11";
> >>>+					function = "spi1";
> >>>+				};
> >>
> >>... can you check which of G8-G11 are actually clock/data and which
> >>are CSn lines?
> >>
> >>CSn lines should all be optional and per-board pinmux - same for the
> >>other spi pinmux.
> >
> >G8 and GSM3 are for clock/data, the other groups (G9-11 and GSM0-2)
> >control the CSn lines. I'll update.
> 
> Re-reading this mail after you published v2, I thought it would
> be a good idea to add this information to the pinmux driver. We
> already have some /* comments */ about the actual function, why
> not add the above, too?

Good idea, I'll prepare a patch.

> Also, I guess G8/GSM3 are for clk/data _and_ cs0n while
> G9-G11/GSM0-GSM2 add cs{1,2,3}n ?

After re-reading carefully the documentation,

G8  -> CLK, SDI, SDO
G9  -> S0n, S1n
G10 -> S2n
G10 -> S3n

GSM0 -> S0n
GSM1 -> S1n
GSM2 -> S2n, S3n
GSM3 -> CLK, SDO

and have no entry for the SPI2 SDI pinmux in my documentation.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
