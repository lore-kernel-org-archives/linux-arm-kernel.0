From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Feb 2014 17:33:26 +0000
Subject: [PATCH RFC 0/2] drivers/base: simplify simple DT-based components
In-Reply-To: <cover.1391793068.git.moinejf@free.fr>
References: <cover.1391793068.git.moinejf@free.fr>
Message-ID: <20140207173326.GD26684@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 06:11:08PM +0100, Jean-Francois Moine wrote:
> This patch series tries to simplify the code of simple devices in case
> they are part of componentised subsystems, are declared in a DT, and
> are not using the component bin/unbind functions.

I wonder - I said earlier today that this works absolutely fine without
modification with DT, so why are you messing about with it adding DT
support?

This is totally the wrong approach.  The idea is that this deals with
/devices/ and /devices/ only.  It groups up /devices/.

It's up to the add_component callback to the master device to decide
how to deal with that.

> Jean-Francois Moine (2):
>   drivers/base: permit base components to omit the bind/unbind ops

And this patch has me wondering if you even understand how to use
this...  The master bind/unbind callbacks are the ones which establish
the "card" based context with the subsystem.

Please, before buggering up this nicely designed implementation, please
/first/ look at the imx-drm rework which was posted back in early January
which illustrates how this is used in a DT context - which is something
I've already pointed you at once today already.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
