From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 8 Jan 2014 16:28:20 +0100
Subject: [PATCH v5 3/4] i2c: mv64xxx: Fix bus hang on A0 version of the
 Armada XP SoCs
In-Reply-To: <52CD6E1E.5040409@free-electrons.com>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <20140108152139.GB15182@katana> <52CD6E1E.5040409@free-electrons.com>
Message-ID: <201401081628.21299.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014, Gregory CLEMENT wrote:
> On 08/01/2014 16:21, Wolfram Sang wrote:

> >> diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
> >> index 8be7e42aa4de..f424c0f89946 100644
> >> --- a/drivers/i2c/busses/i2c-mv64xxx.c
> >> +++ b/drivers/i2c/busses/i2c-mv64xxx.c
> >> @@ -692,6 +692,10 @@ static const struct of_device_id mv64xxx_i2c_of_match_table[] = {
> >>      { .compatible = "allwinner,sun4i-i2c", .data = &mv64xxx_i2c_regs_sun4i},
> >>      { .compatible = "marvell,mv64xxx-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
> >>      { .compatible = "marvell,mv78230-i2c", .data = &mv64xxx_i2c_regs_mv64xxx},
> >> +    {
> >> +            .compatible = "marvell,mv78230-a0-i2c",
> >> +            .data = &mv64xxx_i2c_regs_mv64xxx
> >> +    },
> > 
> > I think a oneliner entry like the entries above is easier to read, but
> > that is very minor...
> 
> By using one line we would break the 80 character rule,
> hat why I did in this way.
> 

It's more a guideline than a strict rule. I agree that one line would
be better here, but it's not important.

	Arnd
