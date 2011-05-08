From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 8 May 2011 19:28:32 +0200
Subject: [PATCH 14/14] [orion5x] Refactor mpp code to use common orion
	platform mpp.
In-Reply-To: <BANLkTikj2xNA3Px1mvrRf0qb6W4M92nPCg@mail.gmail.com>
References: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
	<1304864141-1121-15-git-send-email-andrew@lunn.ch>
	<BANLkTikj2xNA3Px1mvrRf0qb6W4M92nPCg@mail.gmail.com>
Message-ID: <20110508172832.GD4071@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/mach-orion5x/mpp.h b/arch/arm/mach-orion5x/mpp.h
..

 > +#define MPP19_UNUSED ?? ?? ?? ?? ?? MPP(19, 0x0, 1, 1, 1, ?? 1, ?? 1)
> > +#define MPP19_GPIO ?? ?? ?? ?? ?? ?? MPP(19, 0x5, 1, 1, 0, ?? 1, ?? 0)
> > +#define MPP19_GIGE ?? ?? ?? ?? ?? ?? ??MPP(19, 0x1, 1, 1, 1, ?? 1, ?? 1)
> > +#define MPP19_UART ?? ?? ?? ?? ?? ?? ??MPP(19, 0x0, 1, 1, 0, ?? 1, ?? 1)
>
> there have been some effort to enable building single image for
> orion5x/kw/dove etc, and I think the defines here collides with those
> defined by kw.

Please could you point me at this code which merges these three.

I also don't see how these defines cause a problem. In fact, having
just one generic mpp configuration function helps in building one
image for all these SoC. Each SoC will have to retain its per pin
configuration, which is what the mach-*/mpp.h contains, but these
mpp.h are not in the platform, so i don't see how they hinder a single
image.

	Thanks
		Andrew
