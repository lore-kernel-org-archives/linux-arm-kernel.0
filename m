From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 7 Dec 2010 14:15:47 -0500 (EST)
Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	withCONFIG_THUMB2_KERNEL
In-Reply-To: <AANLkTin4oiDGqMJqjYO+5pCM4MffiGiTEKW5WxXx9gfg@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
	<AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
	<AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
	<AANLkTin4oiDGqMJqjYO+5pCM4MffiGiTEKW5WxXx9gfg@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1012071412260.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Dec 2010, Dave Martin wrote:

> On Tue, Dec 7, 2010 at 2:53 PM, Dave Martin <dave.martin@linaro.org> wrote:
> [...]
> > Note that converting to C doesn't mean that code which attempts to
> > copy function bodies will work: you still need to handle the fact that
> > if f() is a C function symbol, then the value of the symbol f is
> > actually the function's base address + 1. ?See my changes in sram.c,
> 
> To clarify, this applies *if* f is a Thumb symbol.

To make it generic, a new macro could be used:

#define SYM_ADDR(x) ((void *)((long)(x) & ~1L))


Nicolas
