From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 5 May 2011 17:38:47 +0200
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <BANLkTikm-raTgJsu7yvaENCfpFsCeKjRNg@mail.gmail.com>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<BANLkTikm-raTgJsu7yvaENCfpFsCeKjRNg@mail.gmail.com>
Message-ID: <20110505153847.GE11267@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:17 Thu 05 May     , Vitaly Wool wrote:
> On Thu, May 5, 2011 at 4:52 PM, Jean-Christophe PLAGNIOL-VILLARD
> <plagnioj@jcrosoft.com> wrote:
> > nearly no-one use it, only amop1, pxa and sa1100 implement it
> 
> What's amop1?
omap1
> 
> > this is the only reason why we need to keep the PLAT_PHY_OFFSET
> > and do not enable the "Patch physical to virtual translations at runtime"
> > support when have MMU enabled
> 
> I'm actually poking around several SoCs that have relatively large and
> fast NOR flash and they do use XIP.
which one?
we do not see them at the mainline
> 
> > As done on AT91
> >
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Cc: Eric Miao <eric.miao@canonical.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> So this is most definitely a NAK from my side. By killing XIP we're
> moving Linux kernel out of Automotive scope.
even on autmotive we see nand and spi flash and will see soon emmc
> 
> I'd rather let at91 go.
no at91 do switch to "Patch physical to virtual translations at runtime"
by default

Best Regards,
J.
