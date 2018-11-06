From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 16:37:24 +0000
Subject: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible
 cut'n'paste error
In-Reply-To: <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <20181106162014.GH30658@n2100.armlinux.org.uk>
 <VI1PR08MB33427CD1C653245DBB979B9B9CCB0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Message-ID: <20181106163724.GK30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 04:33:26PM +0000, David Binderman wrote:
> hello there Russell,
> 
> > linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of >'ufp_exc->fpinst2' to itself.
> 
> >Thanks for the report - it most certainly is a bug introduced by
> >Julien's patches, but I don't get your warning here.? Which compiler
> >produces that warning?
> 
> Not a compiler, cppcheck, a static analyser for C and C++ code.
> 
> Interestingly, more of the same in file linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c
> 
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:84]: (warning) Redundant assignment of 'ASCR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:85]: (warning) Redundant assignment of 'ARSR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:120]: (warning) Redundant assignment of 'ASCR' to itself.
> [linux-4.20-rc1/arch/arm/mach-pxa/pxa3xx.c:121]: (warning) Redundant assignment of 'ARSR' to itself.
> 
> I don't know if these four are also worth fixing.

There are cases where this can be false positives.  In the case of a
status register with write-1-to-clear bits for example.  These ones
look very much like that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
