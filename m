From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Wed, 05 Feb 2014 16:43:03 -0800 (PST)
Subject: [PATCH 1/3] clk: rcar-h2: fix sd0/sd1 divisor table
In-Reply-To: <2298259.CqC51XrMZM@avalon>
References: <1391537858-28593-1-git-send-email-william.towle@codethink.co.uk>
 <52F226A0.5070301@codethink.co.uk>
 <52F23166.1030609@codethink.co.uk> <2298259.CqC51XrMZM@avalon>
Message-ID: <87txcdul4b.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all

> > >>> The clk_div_table for cpg_sd01_div_table[] concurs with the manual
> > >>> but not with values found in the device itself (which are also the
> > >>> same as the ones in arch/arm/mach-shmobile/clock-r8a7790.c).
> > >>> 
> > >>> Update the clk-rcar-gen2.c driver to have the same table as the one
> > >>> used by the mach-shmobile driver which work once further issues are
> > >>> fixed in the clk-rcar-gen2.c driver.
> > >>> 
> > >>> Part of the fix for the following error where the driver reports the
> > >>> 
> > >>> output as 1MHz but is really 97.5MHz:
> > >>>      sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 1
> > >>> MHz
> > >>> 
> > >>> [ben.dooks at codethink.co.uk: updated patch description]
> > >>> Signed-off-by: William Towle <william.towle@codethink.co.uk>
> > >>> Reviewed-by: Ben Dooks <ben.dooks@codethink.co.uk>
(snip)
> > >>>   static const struct clk_div_table cpg_sd01_div_table[] = {
> > >>> +    {  0,  2 }, {  1,  3 }, {  2,  4 }, {  3,  6 },
> > >>> +    {  4,  8 },
> > >>> 
> > >>>       {  5, 12 }, {  6, 16 }, {  7, 18 }, {  8, 24 },
> > >>>       { 10, 36 }, { 11, 48 }, { 12, 10 }, {  0,  0 },
(snip)
> > > I would like feedback from Renesas on this issue if possible. I can
> > > have a quick try at setting the clock value to 10 in u-boot and scope
> > > it out and see what happens.
> > > 
> > > Magnus or Morimoto-san, is there a chance this could be reviewed by
> > > someone in Renesas who has knowledge of the hardware block?
> > > 
> > > [PS, added Kuninori Morimoto to this[
> > 
> > I got William to do a quick test with the following u-boot command
> > 	mw.l 0xE6150074 0xCCC
> > 
> > sdhi0 showed 156MHz output, and it seemed to work. So there is a
> > distinct possibility that the sdh clock also supports setting 12
> > for a /10
> 
> Thank you for trying it out. I'd like feedback from Renesas as well, assuming 
> we don't get a "don't do that or it will cause the universe to collapse - 
> woops, too late" nack, let's respin this patch and merge the two tables 
> instead.

I ask it to Renesas HW team.
Please wait

Best regards
---
Kuninori Morimoto
