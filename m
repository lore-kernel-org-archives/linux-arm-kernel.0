From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Thu, 06 Feb 2014 22:43:37 -0800 (PST)
Subject: [PATCH 1/3] clk: rcar-h2: fix sd0/sd1 divisor table
In-Reply-To: <87txcdul4b.wl%kuninori.morimoto.gx@gmail.com>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
 <52F226A0.5070301@codethink.co.uk>
 <52F23166.1030609@codethink.co.uk> <2298259.CqC51XrMZM@avalon>
 <87txcdul4b.wl%kuninori.morimoto.gx@gmail.com>
Message-ID: <87y51nbey3.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi William, Ben, Laurent

> > > >>>   static const struct clk_div_table cpg_sd01_div_table[] = {
> > > >>> +    {  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
> > > >>> +    {  4,  8 },
> > > >>> 
> > > >>>       {  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> > > >>>       { 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },

According to HW team, datasheet is correct.
Some HW has above un-documented implementation indeed,
but these are not supported.
But, 0x0100 (x1/8) on SD0FC/SD1FC is now supported and documented in
latest datasheet.

> > > sdhi0 showed 156MHz output, and it seemed to work. So there is a
> > > distinct possibility that the sdh clock also supports setting 12
> > > for a /10

According to HW there,
SDHFC will be stopped if you set 0xC.

Best regards
---
Kuninori Morimoto
