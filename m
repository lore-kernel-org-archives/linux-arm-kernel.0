From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 23 Dec 2012 08:40:43 +0000 (UTC)
Subject: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
In-Reply-To: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 21 Dec 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> [This series supersedes the hwmod related patches sent in the
>  "crypto: omap-sham updates" and "crypto: omap-aes updates"
>  series a few weeks ago.]
> 
> This series adds hwmod support for the OMAP SHAM and AES
> modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
> adds device tree info for those modules.

Thanks for working on this, this will get us much closer to being able to 
convert the hwmod code into an OMAP bus.  I haven't looked closely at 
these patches yet, but a few comments/questions:

- Looks like the two DTS patches are the ones with direct dependencies on 
the DMA Engine support patches that you mentioned.  Any objection to me 
taking the series without those two patches?  Then once the DMA Engine 
series goes in, maybe those AM33xx DTS patches can go up?

- The patch series causes AM3517/3505 to crash.  I'd guess this is due to 
the SHAM/AES modules being initialized on those chips, but they probably 
don't exist there.  Can you change the initialization for those on OMAP3 
to only take place on OMAP34xx/36xx GP?  I guess you'd need to create new 
lists for those in the hwmod init.


- Paul
