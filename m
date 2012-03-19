From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 19 Mar 2012 11:08:36 +0200
Subject: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
In-Reply-To: <1329997247-27342-8-git-send-email-rnayak@ti.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-8-git-send-email-rnayak@ti.com>
Message-ID: <1332148116.2144.1.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 2012-02-23 at 17:10 +0530, Rajendra Nayak wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> Now that omap hsmmc init is split into two functions, it's safe
> to mark omap_hsmmc_init and omap_mux related functions to __init.
> 
> This basically reverts the following fixes for the case where
> TWL was compiled as a module:
> 
> a98f77b (ARM: omap: fix section mismatch warning for sdp3430_twl_gpio_setup())
> 8930b4e (ARM: omap: fix section mismatch warnings in mux.c caused by hsmmc.c)
> 
> Additionally it fixes up the remaining section warnings for
> all callers of omap_mux functions.

I only now noticed this patch. This breaks DSI, as the DSI muxing
functions are used during runtime and cannot be marked as __init.

Shall I make a new patch for dss tree that fixes this?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120319/b22db85d/attachment.sig>
