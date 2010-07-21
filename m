From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 21 Jul 2010 12:49:11 +1200
Subject: Your patch: ARM: AMBA: Add pclk definition for platforms using
	primecells
In-Reply-To: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976374051D65@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4C464407.5060305@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2010 11:54 AM, H Hartley Sweeten wrote:
> Hello Russell,
> 
> Your patch added a new clock to the ep93xx platform called "apb_pclk".  This
> clock was already available as "pclk" on that platform.
> 
> Since there are no users of "pclk" in the kernel I have no problems just
> renaming it to "apb_pclk" and removing the dummy_apb_pclk that you added.
> 
> Would you like me to submit the ncessary patch or can you fix it?

The dummy_apb_pclk definition caused a merge conflict in next with the
ep93xx i2s audio clock code, which Stephen wrote a fixup patch for. Can
we sort this out all in one big go? Stephen's original message copied below.

~Ryan

---

> Hi Takashi,
> 
> Today's linux-next merge of the sound tree got a conflict in
> arch/arm/mach-ep93xx/clock.c between commit
> 5c6649e3c1511b183f12d2e884d2c172fe9001e0 ("ARM: AMBA: Add pclk definition
> for platforms using primecells") from the arm tree and commit
> ed67ea82c0d9a163458dc6a69a7a3123db1a8b3b ("EP93xx: Add i2s core support")
> from the sound tree.
> 
> Just overlapping additions.  I fixed it up (see below) and can carry the
> fix as necessary.

---
diff --cc arch/arm/mach-ep93xx/clock.c
index d40826a,8031624..0000000
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@@ -43,9 -43,9 +43,11 @@@ static unsigned long get_uart_rate(stru

  static int set_keytchclk_rate(struct clk *clk, unsigned long rate);
  static int set_div_rate(struct clk *clk, unsigned long rate);
+ static int set_i2s_sclk_rate(struct clk *clk, unsigned long rate);
+ static int set_i2s_lrclk_rate(struct clk *clk, unsigned long rate);

 +static struct clk dummy_apb_pclk;
 +
  static struct clk clk_xtali = {
  	.rate		= EP93XX_EXT_CLK_RATE,
  };
