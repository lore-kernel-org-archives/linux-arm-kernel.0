From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Jul 2012 12:14:59 -0700
Subject: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
In-Reply-To: <1342189185-5306-3-git-send-email-t-kristo@ti.com> (Tero Kristo's
 message of "Fri, 13 Jul 2012 17:19:39 +0300")
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-3-git-send-email-t-kristo@ti.com>
Message-ID: <87k3xpj9sc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> This patch fixes the usecount tracking for omap3+, previously the
> usecount numbers were rather bogus and were not really useful for
> any purpose. Now usecount numbers track the number of really active
> clients on each domain. This patch also adds support for usecount
> tracking on powerdomain level and autoidle flag for clocks that
> are hardware controlled and should be skipped in usecount
> calculations.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>

Minor nit: please avoid using BUG_ON() which will panic the whole
kernel.  Proper error detection is preferred, but your usage, a
WARN_ON() should suffice.

Otherwise,

Reviewed-by: Kevin Hilman <khilman@ti.com>

Kevin
