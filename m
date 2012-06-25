From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 25 Jun 2012 09:07:58 +0300
Subject: [PATCH 05/11] OMAPDSS: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-6-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-6-git-send-email-rnayak@ti.com>
Message-ID: <1340604478.12683.25.camel@lappyti>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 2012-06-22 at 19:18 +0530, Rajendra Nayak wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the omapdss clocks.

You used clk_prepare and clk_unprepare instead of clk_prepare_enable and
clk_disable_unprepare. I didn't check the dss driver yet, but my hunch
is that the clocks are normally not enabled/disabled from atomic
context.

What does the prepare/unprepare actually do? Is there any benefit in
delaying preparing, i.e. is there a difference between prepare right
after clk_get, or prepare right before clk_enable? (And similarly for
unprepare)

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/fb172c0f/attachment.sig>
