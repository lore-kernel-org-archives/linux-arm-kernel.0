From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 17:54:57 +0100
Subject: [PATCH v2 3/5] dmaengine: sun6i: Add 4 as a possible burst value
In-Reply-To: <20160318150946.GO30977@lukather>
References: <cover.1457695169.git.moinejf@free.fr>
 <7898ac737e1cce9542de662f1266d94bd451659e.1457695169.git.moinejf@free.fr>
 <20160311120601.GD8418@lukather>
 <20160311172858.6cffb492a18da7da76e7ed94@free.fr>
 <20160318150946.GO30977@lukather>
Message-ID: <20160318175457.8a7fda7e57551f93fe06e7d2@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Mar 2016 16:09:46 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Fri, Mar 11, 2016 at 05:28:58PM +0100, Jean-Francois Moine wrote:
	[snip]
> > Do you think that we should also check if the requested ports are
> > valid, i.e. have a list/bitmap of the possible input/output ports per
> > SoC, instead of just only the ID of the max port?
> 
> That would require having a map of the possible endpoints for a given
> device, which would be quite difficult to accomplish.
> 
> I don't think customer drivers have access to that anyway, only the
> provider driver is parsing the DT to retrieve the ID. And we already
> trust the DT for so many things it would be a bit pointless to check
> that.

The ports are already checked against 'nr_max_requests' which is the
index of the higher port. I think that this check exists because the
ports are given by the DMA clients.

If this check is needed, as 'nr_max_requests' is lower than 32, 2 maps
(in and out) on 32 bits would do the job.
If this check is not needed (because we trust the DTs), the actual
check (port <= nr_max_requests) could be removed.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
