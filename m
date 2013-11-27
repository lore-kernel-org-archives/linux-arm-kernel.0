From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Nov 2013 10:13:00 -0700
Subject: [PATCH 3/3] ARM: tegra: set SM2 voltage correct
In-Reply-To: <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
References: <cover.1385508112.git.stefan@agner.ch>
 <c9ceead9e3df77b5a33ad654db23c241cd624096.1385508112.git.stefan@agner.ch>
Message-ID: <5296281C.1060403@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 04:45 PM, Stefan Agner wrote:
> Set the requested SM2 voltage to the correct value of 1.8V. The value
> before used to work on TPS658623 since the driver applied a wrong
> voltage table too. However, the TPS658643 used on newer devices uses
> yet another voltage table and those broke that compatibility. The
> regulator driver now has the correct voltage table for both regulator
> versions and those the correct voltage can be used in this device
> tree.

One thing you haven't called out explicitly here is that this series is
an incompatible change to the DT, since the old buggy driver used to
allow old buggy DT content to accidentally work.

I'm not too familiar with who's using mainline on the Colibri boards.
Hopefully everyone doing that is using in-kernel DTs, so this
incompatible change won't be any issue for anyone.

This patch needs to be rolled into patch 2/3 so that "git bisect" isn't
broken.

You mention there's yet another PMIC version used on later boards. Do we
need a new DT for that specfic version of the Colibri board?
