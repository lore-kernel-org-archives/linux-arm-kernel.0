From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 15 Feb 2010 14:04:07 +0100
Subject: [PATCH 3/3] [U300] Set f_max to 24 MHz for MMC
In-Reply-To: <4B7936CE.9020402@csr.com>
References: <1266233040-17124-1-git-send-email-linus.walleij@stericsson.com>
	<4B7936CE.9020402@csr.com>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E84AFAD@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[David Vrabel]

> Linus Walleij wrote:
> > 
> > +	mmci_card->mmc0_plat_data.f_max = 24*1024*1024;
> 
> Is the frequency really 25165824 Hz and not 24000000 Hz?

It's actually 18900000 Hz. This f_max is a physical
limitation and a property of the SoC, so that figure
comes from some semiconductor person.

When combined with the U300 clock framework, the
min() function will resolve to min(18900000, 24000000)
i.e. 18900000 Hz.

Linus Walleij
