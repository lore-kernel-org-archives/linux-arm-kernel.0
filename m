From: balbi@ti.com (Felipe Balbi)
Date: Thu, 6 Nov 2014 10:19:40 -0600
Subject: [PATCH] arm: omap: hwmod: drop unnecessary list initialization
In-Reply-To: <20141104053952.GA15760@saruman>
References: <1405455492-1087-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.02.1407280524160.24161@utopia.booyaka.com>
 <20141104053952.GA15760@saruman>
Message-ID: <20141106161940.GE16896@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 11:39:52PM -0600, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Jul 28, 2014 at 05:24:34AM +0000, Paul Walmsley wrote:
> > On Tue, 15 Jul 2014, Felipe Balbi wrote:
> > 
> > > ml->node and sl->node are currently initialized
> > > by means of INIT_LIST_HEAD(). That initialiation
> > > is followed by a list_add() call.
> > > 
> > > Looking at what both these functions do we will have:
> > > 
> > > 	ml->node.next = &ml->node;
> > > 	ml->node.prev = &ml->node;
> > > 	oi->master->master_ports.next.prev = &ml->node;
> > > 	ml->node.next = &oi->master->master_ports.next;
> > > 	ml->node.prev = &oi->master->master_ports;
> > > 	oi->master->master_ports.next = &ml->node;
> > > 
> > > from this, it's clear that both INIT_LIST_HEAD() calls
> > > are unnecessary and can be safely removed.
> > > 
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > > 
> > > found by code inspection, boot tested on am437x SK on today's
> > > linux-next + pending patches.
> > 
> > Thanks, queued for v3.18.
> 
> This is not on v3.18, what happened ?
> 
> $ git log --author=balbi at ti.com linus/master ^v3.17 -- arch/arm/mach-omap2/omap_hwmod.c
> $

ping

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/b77efa88/attachment.sig>
