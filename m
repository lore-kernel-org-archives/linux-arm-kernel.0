From: khilman@ti.com (Kevin Hilman)
Date: Mon, 07 Nov 2011 16:58:10 -0800
Subject: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
 (Vishwanath BS's message of "Fri, 7 Oct 2011 23:17:44 +0530")
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Message-ID: <87pqh3qvkt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishwa,

Vishwanath BS <vishwanath.bs@ti.com> writes:

> The folowing patch series provides IO Daisychain feature via omap hwmod mux
> framework.

The series looks OK at first glance, but needs a refresh against current
mainline.

Can you refresh this against Tony's 'fixes' branch and re-test.

I tested this on OMAP3430/n900 and noticed that it no longer hit off
mode from idle.  

IOW, If I enable UART timeouts and then enable off mode, I don't
actually ever hit off during idle.  However, if I do a suspend/resume I
see it hits off mode, then subsequent attempts to hit off during idle work.

Can you investigate this?

Kevin
