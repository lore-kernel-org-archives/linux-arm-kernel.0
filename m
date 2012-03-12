From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 12 Mar 2012 12:06:11 +0000
Subject: [PATCH 11/11] ARM: tegra: pcie: Add device tree support
In-Reply-To: <4F59253D.7070100@wwwdotorg.org>
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de>
 <1331218291-16119-12-git-send-email-thierry.reding@avionic-design.de>
 <4F59253D.7070100@wwwdotorg.org>
Message-ID: <20120312120610.GA14020@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2012 at 02:31:41PM -0700, Stephen Warren wrote:
> On 03/08/2012 07:51 AM, Thierry Reding wrote:

> > +- vdd-supply: power supply for controller (1.05V)

> Should those *-supply properties really be optional? I got the
> impression talking to Mark in a different thread that all regulators
> should exist, although their implementation may be via a fixed
> regulator, with no GPIO, as determined by the board design.

Depends on the electronics, if the device can function without a supply
then it is OK for it to be optional.  This is moderately unusual but not
unknown.  It's obviously also OK to omit the supply if the system
doesn't use software regulators at all, though a kernel with regulator
support enabled would need to use dummy regulators to stub things out.
