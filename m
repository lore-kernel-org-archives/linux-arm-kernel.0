From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Sep 2014 10:45:52 +0200
Subject: [PATCH v4 3/5] ARM: tegra: Initialize interrupt controller from DT
In-Reply-To: <20140830155459.GI3683@titan.lakedaemon.net>
References: <1409239879-12376-1-git-send-email-thierry.reding@gmail.com>
 <3113165.EcqFA5vr07@wuerfel> <20140830155459.GI3683@titan.lakedaemon.net>
Message-ID: <4149432.nxIqEBW8Gp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 30 August 2014 11:54:59 Jason Cooper wrote:
> > I have to admit I don't really understand how these work, but what
> > I'd expect to work better is a way to turn the gic code into more
> > of a library that can be used by specialized drivers. In that
> > case you would register a driver for the tegra gic using IRQCHIP_DECLARE
> > and that driver would call a variation of gic_of_init() or gic_init_bases()
> > with the extra stuff as arguments.
> > 
> > We'd have to hack around the fact that all these platforms currently
> > don't list a specialized compatible string, but at least for the future
> > we should be able to do this without special hacks.
> 
> Thomas was talking about this just the other day:
> 
>   https://lkml.kernel.org/r/alpine.DEB.2.10.1408271347210.3323 at nanos

Ah, cool. That seems better than what I had in mind. Yes, let's do that.

	Arnd
