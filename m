From: stefan@datenfreihafen.org (Stefan Schmidt)
Date: Wed, 17 Feb 2010 08:23:32 +0100
Subject: [PATCH 2/2] arm/pxa: Let zeus.c link without CONFIG_PM enabled.
In-Reply-To: <20100216221255.0f905df3@taxman.wild-wind.fr.eu.org>
References: <1266356575-1364-1-git-send-email-stefan@datenfreihafen.org>
	<20100216221255.0f905df3@taxman.wild-wind.fr.eu.org>
Message-ID: <20100217072332.GA3593@excalibur.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On Tue, 2010-02-16 at 22:12, Marc Zyngier wrote:
> On Tue, 16 Feb 2010 22:42:55 +0100
> Stefan Schmidt <stefan@datenfreihafen.org> wrote:
> 
> > Add some safety check for CONFIG_PM around zeus_power_off(). Without it linking
> > can fail like this:
> > 
> > arch/arm/mach-pxa/built-in.o: In function `zeus_power_off':
> > e800.c:(.text+0x2bc8): undefined reference to `pxa27x_cpu_suspend'
> > 
> > Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> > 
> > --
> > 
> > This smells a bit fishy as zeus_power_off() is only mapped to pm_power_off and
> > that one seems to come and go to nowhere. Is this any magic I don't get on a
> > first glance?
> 
> The magic takes place in arch/arm/kernel/process.c.

Ah, thanks a lot. Something learned today. :)

regards
Stefan Schmidt
