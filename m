From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 15 Feb 2011 14:18:37 +0800
Subject: [RFC,PATCH 2/3] clk: Generic support for fixed-rate clocks
In-Reply-To: <4D5A063F.1010102@codeaurora.org>
References: <1297233693.242725.820672531799.2.gpush@pororo>
	<201102150941.00668.jeremy.kerr@canonical.com>
	<4D5A063F.1010102@codeaurora.org>
Message-ID: <201102151418.37780.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravana,

> >> A fixed clock may still have other operations such as enable/disable.
> > 
> > Then it's not a fixed clock; I'd prefer this to be a separate type, as
> > it's now hardware dependent.
> 
> I'm confused. If a clock's rate can't be changed and it can't be enabled
> or disabled, then what's the point of representing that clock
> signal/line as a clock in the driver.

Because the drivers using this clock don't know that it's a fixed clock.

For example, a uart needs to know the rate of its clock source, so that it can 
set its internal divisors to get a valid baud rate. The uart driver will query  
the input rate using clk_get_rate(). The driver still needs to call 
clk_enable/clk_prepare/etc, because on some systems it may have a switchable 
clock.

Cheers,


Jeremy
