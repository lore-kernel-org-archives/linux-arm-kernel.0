From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 15 Jun 2012 20:13:59 +0200
Subject: Device Tree, abstraction of the SoC or the board?
In-Reply-To: <20120615100734.GJ26034@lunn.ch>
References: <1339746250-26650-1-git-send-email-gregory.clement@free-electrons.com>
 <1339746250-26650-4-git-send-email-gregory.clement@free-electrons.com>
 <20120615100734.GJ26034@lunn.ch>
Message-ID: <20120615201359.4ce9df82@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Fri, 15 Jun 2012 12:07:34 +0200,
Andrew Lunn <andrew@lunn.ch> a ?crit :

> So, it looks like the Marvell ASIC engineers moved it for the latest
> SoCs. Could you add a child property of marvell,system-controller
> which indicates where within the system controller the reset
> subcontroller is? Since the two registers are always next to each
> other, we just need one address.

I must say I'm a bit confused in my understanding of what category of
information should be encoded in the Device Tree.

Do we want to encode all the register offsets, bit locations and so on
in the Device Tree? I.e, is the Device Tree suppose to allow porting to
a new SoC without any code modification? Or only to a new board with no
code modification?

For example http://article.gmane.org/gmane.linux.linaro.devel/10554
seems to suggest that the Device Tree will only be used to encode
board-level informations, but not SoC level informations. In that
specific e-mail, the case of the internal SoC clocks are mentioned, and
the OMAP maintainers seem to agree that all the internal SoC clocks
should be listed in C code rather than inside the Device Tree.

On the other hand, the current suggestion of encoding register offsets
inside the Device Tree seems to indicate that we want to encode
SoC-level details inside the Device Tree, which to me (but I might have
gotten everything wrong) contradicts the statement of the OMAP
maintainers mentioned previously.

I'm kind of puzzled by where's the limit between what should be encoded
in the Device Tree and what should remain C code, and I have the
feeling (hopefully incorrect one) that the different sub-architectures
maintainers do not have the same vision on this.

Could anyone show me the direction of the light? :-)

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
