From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 26 Jun 2012 09:55:58 +0300
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
In-Reply-To: <4FE941EA.7050108@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
 <1340604478.12683.25.camel@lappyti> <4FE80C43.6090802@ti.com>
 <1340611133.3395.3.camel@deskari> <4FE85005.4090303@ti.com>
 <1340630090.3395.85.camel@deskari> <4FE941EA.7050108@ti.com>
Message-ID: <1340693758.2093.15.camel@lappyti>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-26 at 10:30 +0530, Rajendra Nayak wrote:

> > So as far as I see, clocks are never handled in atomic context. Is
> > everything related to the base clk stuff already in mainline? Can I take
> > the clk_prepare/unprepare patch into my omapdss tree?
> 
> Well the Common Clk framework is already in mainline, but we still don;t
> have CONFIG_COMMON_CLK enabled for our builds yet. So until we do so,
> clk_prepare/unprepare will just be stubs which do nothing.

But if I understood correctly, clk_prepare and clk_unprepare are anyway
no-ops with dss clocks, even when CONFIG_COMMON_CLK is enabled?

My point was only to understand if I can safely take the patch into
omapdss tree, instead of it going through l-o, to avoid any possible
conflicts.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120626/ab95f1a0/attachment.sig>
