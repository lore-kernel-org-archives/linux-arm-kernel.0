From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Dec 2015 15:02:59 +0000
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <20151222125300.GH8644@n2100.arm.linux.org.uk>
References: <1450723442-1518-1-git-send-email-festevam@gmail.com>
 <20151222122154.GD26290@tiger>
 <CAOMZO5A8BEkNvrazmksRBRUQw+4mWwbfKtrK6KzD3XK5L5Fs7w@mail.gmail.com>
 <1450788454.2637.17.camel@pengutronix.de>
 <20151222125300.GH8644@n2100.arm.linux.org.uk>
Message-ID: <20151222150259.GL8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 12:53:00PM +0000, Russell King - ARM Linux wrote:
> On Tue, Dec 22, 2015 at 01:47:34PM +0100, Lucas Stach wrote:
> > But to be honest I would like to give etnaviv a cycle to stabilize
> > until we enable it by default. With i.MX6QP now hitting the street and
> > basically no testing of etnaviv being done there until now, I would
> > rather not have it in the defconfig just now. It's not like it's hard
> > for people willing to test this to enable a single Kconfig option...
> 
> I already have an iMX6QP uSOM for the Hummingboard/Cubox-i, but I've
> been holding back testing it because (from what I've seen of the QP
> patches) I think it needs different settings for stuff like pinmux
> and similar?
> 
> If the QP stuff gets into the kernel soon, I'll throw the uSOM onto
> one of the many hummingboards I have here and add it into the etnaviv
> test pool.

I'm told by Jon that it's (basically) not as simple as that for several
reasons, mainly u-boot related, and u-boot is now one hell of a mess.

Apparently, Jon tried to submit u-boot support for Hummingboards upstream,
but it was rejected by u-boot developers saying "they didn't like it and
it wasn't "proper" with no information on how they wanted it fixed.".

When Jon tried pushing them privately, they said "they would only accept
"finished" patches."

However, u-boot people subsequently took _incomplete_ patches from someone
else to support _just_ the iMX6D Hummingboard.  The result is that the
SDRAM controller is incorrectly setup for the other versions of the
Hummingboards.

Overall, this means that SolidRun's u-boot is now significantly different
from mainline u-boot - and now u-boot needs additional modification to
support the QP parts.  I suspect Jon will just have to say "screw mainline
u-boot, we're keeping our own vendor branch of it."  He doesn't want to,
he wants to be a good open source citizen, but when faced with this kind
of politics, I can see why people decide to say "screw contributing to
mainline" and keep their own vendor trees.

So... I'm going to have to wait for Jon to find time to spin up patches
for SolidRun's u-boot branch as well before I can do any testing with
the iMX6QP hardware.

In other words, I've no idea if or when I'll be able to use the iMX6QP
hardware I have, because open source projects sometimes become political
and suck.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
