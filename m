From: julia@diku.dk (Julia Lawall)
Date: Mon, 24 Jan 2011 21:28:17 +0100 (CET)
Subject: [PATCH 2/4] arch/arm/mach-at91/clock.c: Add missing IS_ERR test
In-Reply-To: <4D3DDD07.1030809@bluewatersys.com>
References: <1295898922-18822-1-git-send-email-julia@diku.dk>
	<1295898922-18822-3-git-send-email-julia@diku.dk>
	<4D3DD964.9020107@bluewatersys.com>
	<Pine.LNX.4.64.1101242058430.3167@ask.diku.dk>
	<20110124200515.GA30963@albatros>
	<4D3DDD07.1030809@bluewatersys.com>
Message-ID: <Pine.LNX.4.64.1101242126570.3167@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Julia is correct. Some architectures can return NULL from clk_get, but I
> didn't check the at91 before posting :-/. If we can't return NULL from
> clk_get then we shouldn't bother checking for it. I do think we should
> drop the !IS_ERR(clk_get(dev, func)) check though.

It seems a bit subtle, because the clk manipulated by clk_get in the call 
of clk_get(dev, func) is not necessarily the same as the one in 
clock_associate.  But perhaps this is the only possibility in practice?

julia
