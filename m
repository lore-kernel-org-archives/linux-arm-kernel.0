From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 10:48:42 -0700
Subject: OMAP v3.10-rc regressions that no one's fixed
In-Reply-To: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
References: <alpine.DEB.2.02.1306100716560.4604@utopia.booyaka.com>
Message-ID: <20130612174842.GQ8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130610 00:27]:
> 
> Hi folks -- particularly TIers working on mainline,
> 
> There are several regressions that started with v3.10-rc that no one's 
> fixed for over a month.  Some of them should be quite easy:
> 
> * 37xx EVM: boot fails
>   - as of v3.10-rc1
>   - Cause unknown

This one is probably because of broken GPIO numbering in
the board file that uses hardcoded GPIOs for what are probably
twl GPIOs.

Does commenting out omap3_evm_display_init() in the board file
fix the booting for you?

If so, we should probably mark omap3_evm_display_init() with
CONFIG_BROKEN for now rather than add more late init callback
functions for the twl code.

Regards,

Tony
