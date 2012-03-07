From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 07 Mar 2012 17:43:43 -0500 (EST)
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <20120307213009.GF18787@n2100.arm.linux.org.uk>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <20120307180815.GA27213@game.jcrosoft.org> <4F57AB92.6060907@wwwdotorg.org>
 <20120307183633.GB27213@game.jcrosoft.org> <4F57C4C6.2070602@wwwdotorg.org>
 <alpine.LFD.2.02.1203071537130.24151@xanadu.home>
 <20120307213009.GF18787@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1203071644180.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Mar 2012, Russell King - ARM Linux wrote:

> On Wed, Mar 07, 2012 at 04:03:04PM -0500, Nicolas Pitre wrote:
> > Well, I do have a patch series getting rid of ZRELADDR entirely, and 
> > AUTO_ZRELADDR would then become implicit, unless CONFIG_PHYS_OFFSET is 
> > defined.
> 
> Not possible, unless you're goign to also rip out uImage support.

I wish I could.  At least this new "noload" option would make uImage 
compatible with this.  That won't help existing u-Boot installations 
though, which is why I didn't post that patch series yet as I still 
haven't found a good fallback.

> Otherwise, how do we deal with platforms like Versatile Express where
> uboot does a funky relocation of data depending on whether the uImage
> it's loading is for the low 256MB RAM mapping or the high 1GB RAM
> mapping.

Doesn't it use AUTO_ZRELADDR?  With the newer u-Boot, you'd just load 
uImage to whatever address and u-Boot won't mess with it.


Nicolas
