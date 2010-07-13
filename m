From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 13 Jul 2010 13:00:51 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100713074449.GA20118@n2100.arm.linux.org.uk>
References: <1277183247-4557-1-git-send-email-viresh.kumar@st.com>
	<20100709124050.GF22845@n2100.arm.linux.org.uk>
	<AANLkTikm-wupuQA1_zsmqf3jrpavkMaw8Bt-GWb04TSo@mail.gmail.com>
	<20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
Message-ID: <AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/13 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Sat, Jul 10, 2010 at 05:36:54PM +0200, Linus Walleij wrote:

>> Aha I get it, then it looks good...
>
> Is that an Ack for the patch?

Yep! FWIW
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

> I think there's one change I'd like, which is to change "busck" to
> "apb_pclk" to make it clear what it's referring to.

Looks good.

> Also, is there any chance you can convert your platform(s) over to use
> it before I merge this patch?

I can take a round over the U300 within a few days, Rabin can
maybe look at the U8500.

In the U300 (maybe the U8500 as well, I don't know OTOH) the
APB pclk and e.g. SSPCLK is simply just wired together and
connected to the same clock terminal. This means that currently
the PCLK is toggled on/off in unison with the SSPCLK all the time
already, and it's working.

Since that works, it means that we can likely insert
amba_bus_clk_[disable|enable] at the same sites that we have
this in the current code for the external clocks at the same time,
atleast for pl011, pl022 and pl180.

Yours,
Linus Walleij
