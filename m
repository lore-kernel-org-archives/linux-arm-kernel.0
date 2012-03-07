From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Mar 2012 21:30:09 +0000
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <alpine.LFD.2.02.1203071537130.24151@xanadu.home>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <20120307180815.GA27213@game.jcrosoft.org> <4F57AB92.6060907@wwwdotorg.org>
 <20120307183633.GB27213@game.jcrosoft.org> <4F57C4C6.2070602@wwwdotorg.org>
 <alpine.LFD.2.02.1203071537130.24151@xanadu.home>
Message-ID: <20120307213009.GF18787@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 07, 2012 at 04:03:04PM -0500, Nicolas Pitre wrote:
> Well, I do have a patch series getting rid of ZRELADDR entirely, and 
> AUTO_ZRELADDR would then become implicit, unless CONFIG_PHYS_OFFSET is 
> defined.

Not possible, unless you're goign to also rip out uImage support.

Otherwise, how do we deal with platforms like Versatile Express where
uboot does a funky relocation of data depending on whether the uImage
it's loading is for the low 256MB RAM mapping or the high 1GB RAM
mapping.
