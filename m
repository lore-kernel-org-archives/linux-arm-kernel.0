From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 3 Oct 2014 10:11:02 -0400
Subject: [PATCH 0/8] Armada XP pinctrl consolidation and ix4-300d fixes
In-Reply-To: <-7443282711873112734@unknownmsgid>
References: <1411157684-6991-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <-7443282711873112734@unknownmsgid>
Message-ID: <20141003141102.GJ3895@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Sun, Sep 21, 2014 at 04:11:23PM +0200, Benoit Masson wrote:
> > Le 19 sept. 2014 ? 22:14, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> a ?crit :
> > this is a patch set preparing barebox support for ix4-300d. As usual,
> > I stumbled upon a few nice-to-haves before actually touching ix4-300d
> > dts. As it is a mach-mvebu thing, I just added the related mailing
> > lists instead of each of the DT maintainers.
> >
> > First 5 patches consolidate SoC-specific pinctrl nodes to one common
> > node in armada-xp.dtsi, compatible overwrites for each SoC, and node
> > alias usage for each board. Also, ge{0,1} pinctrl settings are moved
> > to the common node from one board specific node.
> >
> > Last 3 patches then use that ge{0,1} pinctrl settings on ix4-300d which
> > is vital for bootloader init. During exploration of ix4-300d, I also
> > found a i2c eeprom that has not been added to the dts, yet. Finally,
> > there is only one 74hc595 on ix4 mainboard while dts property is set
> > for two.
> >
> > I cannot recall in detail what is on that eeprom, but IIRC it is nothing
> > important. Some reg,addr pairs for some init stuff that should have
> > already been done by stock u-boot. Anyway, adding the node will do no
> > harm.
> >
> > Patches are based on v3.17-rc1 and intended for v3.18 but I am not in
> > a hurry. I only compile tested this, so a formal Tested-by from Benoit
> > for the ix4 and any other Armada XP board would be great.
> 
> I'm not sure what to test since I only receive some patch from the
> series of 8. Should I get all 8 or only those you sent me. I'll be
> able to test during next week.

Did you ever get a chance to test this series?

thx,

Jason.
