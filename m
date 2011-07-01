From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Jul 2011 11:09:26 +0200
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for
	imx23/imx28
In-Reply-To: <4E0D8C04.6010409@freescale.com>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107010029.51965.arnd@arndb.de> <4E0D8C04.6010409@freescale.com>
Message-ID: <201107011109.27206.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 July 2011 10:57:40 Huang Shijie wrote:
> >> It's annoying, but it really saves some lines.
> > It would save more lines if you introduce the macros globally and
> > convert all existing resource definitions ;-)
> The origin code did not use any macros.
> Some one suggested me to use macros.
> So i used the macros.
> 
> Do i have to drop the macros?

Can you find out who made the suggestion? Let's first reach consensus
about how we want to do these things in the future.

My opinion is that we should not have macros like these in any platform
specific code: If the macros are a good idea, we should define them
globally and let everyone use the same macros. If we decide not to have
them in global code, it would be even worse to have them in specific
platforms.

	Arnd
