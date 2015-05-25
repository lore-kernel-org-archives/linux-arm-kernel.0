From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 25 May 2015 11:01:00 +0200
Subject: [PATCH] ARM: berlin: add SPI nodes for BG2Q
In-Reply-To: <555D1706.7040309@gmail.com>
References: <1432126385-27402-1-git-send-email-antoine.tenart@free-electrons.com>
 <555D1706.7040309@gmail.com>
Message-ID: <20150525090100.GC29660@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 01:21:42AM +0200, Sebastian Hesselbarth wrote:
> On 20.05.2015 14:53, Antoine Tenart wrote:

> >+
> >+				spi0_pmux: spi0-pmux {
> >+					groups = "G8", "G9", "G10", "G11";
> >+					function = "spi1";
> >+				};
> 
> ... can you check which of G8-G11 are actually clock/data and which
> are CSn lines?
> 
> CSn lines should all be optional and per-board pinmux - same for the
> other spi pinmux.

G8 and GSM3 are for clock/data, the other groups (G9-11 and GSM0-2)
control the CSn lines. I'll update.

> >  			};
> >
> >  			chip_rst: reset {
> >@@ -473,6 +492,20 @@
> >  				};
> >  			};
> >
> >+			spi1: spi at 5000 {
> >+				compatible = "snps,dw-apb-ssi";
> >+				reg = <0x6000 0x100>;
> 
> s/spi at 5000/spi at 6000/

Oops.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
