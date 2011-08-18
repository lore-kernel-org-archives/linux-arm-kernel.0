From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 18 Aug 2011 11:25:39 -0500
Subject: [PATCH v4] amba: consolidate PrimeCell magic
In-Reply-To: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
References: <1313654311-2283-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F3884BB677@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, August 18, 2011 12:59 AM, Linus Walleij wrote:
>
> Since two drivers use the PrimeCell scheme without using the
> amba_bus driver logic, let's break the magic lookups out as
> static inlines in the <linux/amba/bus.h> header so we get
> some consolidation anyway. Delete the primecell ID check in
> common/pl330.c since it is only used from the amba_bus driver
> in drivers/dma, which is already doing the same check when
> probing in drivers/amba/bus.c.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Viresh Kumar <viresh.kumar@st.com>
> Acked-by: H Hartley Sweeten <hartleys@visionengravers.com>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
> Acked-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes V3->v4:
> - Fix up sparse warning due to inelegant cast to (u32) in vic.c,
>   we cast to (unsigned long) and sparse is happy.

Thanks!

One nit...

+	/*
+	 * Identify which VIC cell this one is, by reading the ID - some
+	 * implementations have two VICs in the same page but only one set
+	 * of ID registers at the end, so we need to adjust the base to
+	 * reference the page offset. All VIC:s are size 4K.
                                           ^

Is this supposed to be VIC's

Regards,
Hartley
