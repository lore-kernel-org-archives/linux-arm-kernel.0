From: w@1wt.eu (Willy Tarreau)
Date: Wed, 3 Jul 2013 21:07:53 +0200
Subject: [RFC] Add .dts file for Netgear ReadyNAS 102
In-Reply-To: <20130703094203.37562f9c@skate>
References: <20130702151407.01680d21@skate>
 <20130702133337.GA17110@titan.lakedaemon.net> <20130702153825.139a93a5@skate>
 <20130702134421.GC17110@titan.lakedaemon.net> <87obakho6d.fsf@natisbad.org>
 <20130702174111.GF17110@titan.lakedaemon.net> <87y59ows4n.fsf@natisbad.org>
 <20130702220936.GC10215@1wt.eu> <20130702232311.GA3949@localhost>
 <20130703094203.37562f9c@skate>
Message-ID: <20130703190753.GB16785@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, Jul 03, 2013 at 09:42:03AM +0200, Thomas Petazzoni wrote:
> Wasn't also part of the TODO-list to make pxa3xx_nand divorce from the
> PXA-specific DMA API, and use instead the PXA dmaengine driver, through
> the DMA engine API? As far as I remember, this was one of the
> prerequisite to be able to re-use the driver in a non-PXA context.
> There is a patch that was floating around doing this conversion (I
> could dig the relevant link if needed), but of course it needs to be
> tested, and we don't have PXA3xx hardware, so making changes to this
> driver without breaking it is quite tedious.

Thus I think it would make more sense to split the driver (at least at
the beginning) in order not to risk breaking anything. If the driver is
copy-pasted from pxa3xx, the merge will still be doable later when
someone can test it.

Just my two cents, cause I hate breaking working stuff.

Best regards,
Willy
