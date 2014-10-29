From: sre@ring0.de (Sebastian Reichel)
Date: Wed, 29 Oct 2014 19:59:57 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <5450EEE7.8070801@ti.com>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
 <20141028221243.GU2542@atomide.com> <5450EEE7.8070801@ti.com>
Message-ID: <20141029185957.GA3723@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 29, 2014 at 08:43:03AM -0500, Nishanth Menon wrote:
> On 10/28/2014 05:12 PM, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> >> Hi,
> >>
> >> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> >>> +
> >>> +	if (!of_have_populated_dt())
> >>> +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> >>> +
> >>
> >> Maybe use WARN so that the warning is more verbose and kernel gets tainted?
> > 
> > Well I was hoping to avoid annoying people with the trace.
> > But can do that if people prefer that, what do others think?
> > 
> 
> WARN is better and eye catchy. Also, could we add information on when
> the support will be removed since we call it deprecated?

I also think, that more eye catchy is better.

Apart from that I wonder if we should drop support on a
board-by-board basis and then drop omap3 support completly once all
boards have been dropped.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141029/5168a2d0/attachment.sig>
