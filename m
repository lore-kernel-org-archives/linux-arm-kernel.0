From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Dec 2017 10:00:30 +0100
Subject: [PATCH 2/4] ARM: dts: vf610-zii-dev-rev-b: fix interrupt for
 GPIO expander
In-Reply-To: <E1eRnWg-0006VE-GI@rmk-PC.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWg-0006VE-GI@rmk-PC.armlinux.org.uk>
Message-ID: <20171221090030.GA6683@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 11:11:50PM +0000, Russell King wrote:
> The interrupt specification for the GPIO expander is wrong - the
> expander is wired to PTB28, which is GPIO98.  GPIO98 is on gpio chip
> 3, not 2.

Hi Russell

I'd also seen this interrupt storm. The whole interrupt architecture
for this expander does not look so good, so i just assumed it was a
design issue. Instead, it was me who probably made a typ0 :-(

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
