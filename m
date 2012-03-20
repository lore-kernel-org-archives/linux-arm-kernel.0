From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 20 Mar 2012 09:30:51 +0200
Subject: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
In-Reply-To: <20120319180928.GA9859@atomide.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-8-git-send-email-rnayak@ti.com>
 <1332148116.2144.1.camel@deskari> <1332152442.2144.27.camel@deskari>
 <20120319180928.GA9859@atomide.com>
Message-ID: <1332228651.2409.5.camel@lappy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-03-19 at 11:09 -0700, Tony Lindgren wrote:

> I've updated your patch a bit for the comments a bit and marked
> omap4_hdmi_mux_pads as __init, will apply to fixes. Updated patch
> below.

Hmm, is there something funny with these init changes now...

Initially the situation was that there were no __inits in display.c's
mux functions. Then "Mark omap_hsmmc_init..." patch added __inits to all
of them. My patch removed the __inits from dsi functions, but left them
to hdmi functions.

But now you modified my patch to add the __inits to hdmi functions.
Which should already have them from the "Mark omap_hsmmc_init..." patch.

 Tomi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120320/9ca92661/attachment.sig>
