From: ynvich@gmail.com (Sergei Ianovich)
Date: Wed, 11 Dec 2013 08:30:15 +0400
Subject: [PATCH 02/11] arm: pxa27x: support ICP DAS LP-8x4x
In-Reply-To: <201312102257.33942.arnd@arndb.de>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <CACRpkdYF-O6Qgjue6x+R6fVuSXSyO4YHw1meusuyQhtSA9PnvQ@mail.gmail.com>
 <1386706817.7152.254.camel@host5.omatika.ru>
 <201312102257.33942.arnd@arndb.de>
Message-ID: <1386736215.7152.259.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-10 at 22:57 +0100, Arnd Bergmann wrote:
> It should be possible to make it a loadable module, with deferred
> probing etc. You wouldn't use IRQCHIP_DECLARE() for this though,
> but instead have a platform driver that sets up the irq domain.

Thanks for explaning.

> It probably makes sense to have a single driver file for the
> FPGA device that does this, and only split out the other devices
> from it that consume the irqs.

Is drivers/irqchip/ the right place this driver?

I am asking because there is no tristate config options in
drivers/irqchip/Kconfig at the moment.
