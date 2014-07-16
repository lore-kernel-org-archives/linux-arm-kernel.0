From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Jul 2014 12:00:12 +0100
Subject: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20140716080133.GI7978@ulmo>
References: <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com> <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk> <20140714092434.GA9755@ulmo>
 <20140714102203.GD6800@sirena.org.uk> <53C58DCB.90502@nvidia.com>
 <20140715225252.GD17528@sirena.org.uk> <20140716080133.GI7978@ulmo>
Message-ID: <20140716110012.GL17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 10:01:34AM +0200, Thierry Reding wrote:
> On Tue, Jul 15, 2014 at 11:52:52PM +0100, Mark Brown wrote:

> > This looks fine, can you submit properly please?  For the I2C address
> > why not just have an interface to get the regmap and then provide a way
> > to get the underlying device back from the regmap?

> Is it mandatory for regulators to use regmap? Also I'm not sure how this

No, but this is for a limited subset of devices that the hardware knows
how to write to directly which means that they're restricted to things
that can be supported with regmap (or already know how to interact with
the hardware and don't need this interface at all).  The proposed patch
already relies on regmap - it's passing back the information the regmap
helpers use.

> will work with MFDs, since the device may not be the actual bus device,
> but rather a child of the MFD (and what we want access to is the MFD).

> Perhaps for regmaps that would work in most cases since MFDs seem to
> aften share the regmap with their children. However, the code in
> regulator_register() at least indicates that even then it's possible to
> have a regmap in children that's different from the top-level MFD.

Right, drivers can say exactly which regmap to use.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/68871552/attachment.sig>
