From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 3 Feb 2010 17:52:20 +0000
Subject: [PATCH v3 2/7 RE-SEND] ARM: S5P6442: Add clock support for S5P6442
In-Reply-To: <25e057c01002020741l157f57e3s431716adcf038a83@mail.gmail.com>
References: <1265116976-10140-1-git-send-email-kgene.kim@samsung.com>
	<25e057c01002020741l157f57e3s431716adcf038a83@mail.gmail.com>
Message-ID: <20100203175220.GA13267@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2010 at 04:41:24PM +0100, roel kluin wrote:
> > This patch adds clock support for S5P6442. This patch adds the clock
> > register definitions and the various system clocks in S5P6442.
> 
> > +static struct clksrc_clk clk_mout_epll = {
> > + ? ? ? .clk ? ?= {
> > + ? ? ? ? ? ? ? .name ? ? ? ? ? = "mout_epll",
> > + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
> > + ? ? ? },
> > + ? ? ? .sources ? ? ? ?= &clk_src_epll,
> > + ? ? ? .reg_src ? ? ? ?= { .reg = S5P_CLK_SRC0, .shift = 8, .size = 1 },
> > +};
> 
> This appears not to be used, is this implemented in another patch?

Not sure, although I'm not going to argue about it if it isn't.

This new version is better than trying to deal with the switch() statements
which initialised the base hclk values.
 
> Roel
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
