From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 8 Apr 2014 08:38:13 +0300
Subject: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
In-Reply-To: <20140408001339.GA15842@atomide.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com>
 <20140408001339.GA15842@atomide.com>
Message-ID: <53438B45.2090209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/14 03:13, Tony Lindgren wrote:
> Tomi,
> 
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140121 03:01]:
>> Add DT support for panel-dpi.
> 
> Looks like this patch did not get merged or am I missing
> something?

Yes, I dropped it. None of the boards that I converted used panel-dpi.
There was so much discussions about the display bindings, so I thought
it's better to leave out all but the needed patches.

> As you probably are aware, we have at least these boards
> needing it before we can remove the omap3 legacy support:
> 
> board-am3517evm.c
> board-cm-t35.c
> board-devkit8000.c
> board-ldp.c
> board-overo.c
> 
> We could probably set the display timings based on the
> compatible flag in the driver if that's an issue?

The timings shouldn't be an issue. But there's the backlight GPIO,
currently handled by panel-dpi, which should be removed from the panel.
We should use gpio-backlight for that one.

> And then board-omap3pandora.c also needs support for
> panel_tpo_td043mtea1_platform_data.

Yep, there's still much to do for DSS DT support. Hopefully it will be
easier now that the core support is there. I'll continue working on the
remaining boards and panels. However, I don't have any of the remaining
boards, so help is of course appreciated.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140408/b23108fb/attachment.sig>
