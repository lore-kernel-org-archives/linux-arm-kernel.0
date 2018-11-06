From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Nov 2018 16:20:15 +0000
Subject: linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576: possible
 cut'n'paste error
In-Reply-To: <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
References: <VI1PR08MB3342D4ADBFBC43F2BE2FD34D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
 <VI1PR08MB33420789A2AA1096D3F5FC9D9CCA0@VI1PR08MB3342.eurprd08.prod.outlook.com>
Message-ID: <20181106162014.GH30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 01:53:13PM +0000, David Binderman wrote:
> Hello there,
> 
> 2nd try. Plain text might help.

Yep, Linux kernel development generally doesn't like wasteful html
emails, sorry.

> linux-4.20-rc1/arch/arm/vfp/vfpmodule.c:576]: (warning) Redundant assignment of 'ufp_exc->fpinst2' to itself.
> 
> Source code is
> 
> ? ? ? ?ufp_exc->fpexc = hwstate->fpexc;
> ?? ? ? ufp_exc->fpinst = hwstate->fpinst;
> ?? ? ? ufp_exc->fpinst2 = ufp_exc->fpinst2;

Thanks for the report - it most certainly is a bug introduced by
Julien's patches, but I don't get your warning here.  Which compiler
produces that warning?

Julien - unfortunately, I've just asked Linus to take another fix
for Spectre, so we're going to have to wait a bit before I can
submit something for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
