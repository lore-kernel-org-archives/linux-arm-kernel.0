From: premi@ti.com (Premi, Sanjeev)
Date: Sun, 26 Jun 2011 00:21:52 +0530
Subject: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
In-Reply-To: <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
	<86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Koen Kooi
> Sent: Saturday, June 25, 2011 1:47 PM
> To: linux-omap at vger.kernel.org List
> Cc: linux-arm-kernel; Paul Walmsley
> Subject: Re: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
> 
> 
> Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende geschreven:
> 
> > The current selection of the GPTIMER on was result of
> > a hardware issue in early versions of the Beagleboards
> > (Ax and B1 thru B4). [1] [2]
> > 
> > Its been long since the hardware issue has been fixed.
> > This patch uses GPTIMER 1 for all newer board revisions
> > incl. Beagleboard XM.

[sp] I didn't include a reason - because the problem may not
     be reproducible on the public trees.

     During tests performed in internal development trees, the
     BogoMIPS calculations @ 1GHz wouldn't go beyond "830-850"
     range. While there was no such inconsistency on OMAP3EVM.

     After few days of debug GPTIMER12 came to be only difference.
     Tracing GPTIMER12 in the spec proved quite a challenge; the
     as timer is not included in the TRM and corresponding interrupt
     is marked reserved. Paul (in cc:) obviously had access to
     documents that we don't.

     This patch is merely trying to bring parity in use of GPTIMER
     across OMAP3 boards (AND use documented IP) - taking note of
     many Beagleboards where current code is necessary.

~sanjeev
