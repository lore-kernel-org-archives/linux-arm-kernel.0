From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Feb 2017 15:49:54 +0100
Subject: [GIT PULL 1/2] Broadcom dts changes for 4.11 (part 2)
In-Reply-To: <20170202020607.31682-1-f.fainelli@gmail.com>
References: <20170202020607.31682-1-f.fainelli@gmail.com>
Message-ID: <1912177.f24aWX6xy5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 1, 2017 6:06:07 PM CET Florian Fainelli wrote:
> Please note that because of the "clk" topic branch merged by Eric, we end-up with
> pulling in v4.10-rc2 which is responsible for the funny diff here.

It's generally better to avoid those back-merges entirely, that is not
the only problem with them. Our DT branch is already based on -rc3,
so it's not a back-merged for me, and I think that's ok when I send
it upstream.

However, I see that you do pull in these changes:

Eric Anholt (5):
      clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
      clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
      clk: bcm2835: Add leaf clock measurement support, disabled by default

I'd rather not have those in next/dt at all, and at the very least
we require an explanation in the changelog about why you are sending
them to arm-soc. I assume that they are present in the clk-next
tree and won't get rebased, but that's not clear from your pull
request.

Are you doing an incompatible DT binding change that requires changing
the dts files and the driver together? If so, that also needs to be
in the changelog (or avoided if at all possible).

If you send the other changes again today, I'll pull them right away,
and then we can talk about what we do for the clk-bcm2835 changes.

	Arnd
