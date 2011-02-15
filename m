From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 15 Feb 2011 09:41:00 +0800
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <4D54738C.80900@bluewatersys.com>
References: <1297233693.242725.820672531799.2.gpush@pororo>
	<4D54738C.80900@bluewatersys.com>
Message-ID: <201102150941.00668.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

> A fixed clock may still have other operations such as enable/disable.

Then it's not a fixed clock; I'd prefer this to be a separate type, as it's 
now hardware dependent.

> Maybe do something like this instead:
> #define INIT_CLK_FIXED(name, ops, r) { 		\
> 	.clk = INIT_CLK(name.clk, ops, rate), 	\
> 	.clk.ops.get_rate = clk_fixed_get_rate, \
> 	.rate = (r),				\
> }
> 
> That's untested though. I'm not sure if you can reliably assign
> something twice in a struct initialiser?

also, clk->ops is a const.

Cheers,


Jeremy
