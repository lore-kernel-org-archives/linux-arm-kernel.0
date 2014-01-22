From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 22 Jan 2014 16:21:26 -0300
Subject: [PATCH v2 5/5] [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from
 omap3
In-Reply-To: <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
 <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
Message-ID: <52E01A36.40502@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Christoph,

On 01/22/2014 04:04 PM, Christoph Fritz wrote:
> DBB056 doesn't use DSI for its display, but omap3 forces this
> erroneously for all its boards:
> 
>   | OMAP DSS rev 2.0
>   | omapdss DPI error: can't get VDDS_DSI regulator
>   | omapfb omapfb: failed to connect default display
>   | omapfb omapfb: failed to init overlay connections
>   | omapfb omapfb: failed to setup omapfb
>   | platform omapfb: Driver omapfb requests probe deferral
> 
> So this patch just disables it for omap3. Consider this as a hack!
> Is there a proper fix for this issue?

It is also a hack but I solved on the IGEPv2 board by adding a regulator-name =
"vdds_dsi" to the VPLL2 regulator as suggested by Tony.

Look at commit 2f2befd8 ("ARM: dts: omap3-igep0020: name twl4030 VPLL2 regulator
as vdds_dsi")

Having the workaround in the Device Tree is better IMHO since this is a
per-board configuration. That can be later removed once the DSS DT bindings are
added to mainline.

Thanks a lot and best regards,
Javier
