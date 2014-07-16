From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 16 Jul 2014 10:01:34 +0200
Subject: [PATCH 01/13] clk: tegra: Add binding for the Tegra124 DFLL
 clocksource
In-Reply-To: <20140715225252.GD17528@sirena.org.uk>
References: <CAL1qeaFF0ZpUFovxTuLXrBPRg2Lbf-754Z=ztD5HFZPbfnDsAw@mail.gmail.com>
 <53C01558.3090607@nvidia.com>
 <CAL1qeaHETQ7kSGNjPiwi_9WNMtr9qZp0KwjZCCxY29+_N4AcuA@mail.gmail.com>
 <53C01D17.2050906@nvidia.com> <20140714083854.GO2081@ulmo>
 <20140714091233.GC6800@sirena.org.uk> <20140714092434.GA9755@ulmo>
 <20140714102203.GD6800@sirena.org.uk> <53C58DCB.90502@nvidia.com>
 <20140715225252.GD17528@sirena.org.uk>
Message-ID: <20140716080133.GI7978@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 11:52:52PM +0100, Mark Brown wrote:
> On Tue, Jul 15, 2014 at 11:23:39PM +0300, Tuomas Tynkkynen wrote:
> 
> > That sounds indeed useful for this case. How'd the following interface
> > sound for the register offset / selector-to-register-value conversion?
> > The I2C address would be a bit trickier to get as it would touch the
> > regmap stuff as well, but perhaps it would be a good idea to have a
> > phandle to the I2C device itself, and then parse the reg field for
> > the address.
> 
> This looks fine, can you submit properly please?  For the I2C address
> why not just have an interface to get the regmap and then provide a way
> to get the underlying device back from the regmap?

Is it mandatory for regulators to use regmap? Also I'm not sure how this
will work with MFDs, since the device may not be the actual bus device,
but rather a child of the MFD (and what we want access to is the MFD).
Perhaps for regmaps that would work in most cases since MFDs seem to
aften share the regmap with their children. However, the code in
regulator_register() at least indicates that even then it's possible to
have a regmap in children that's different from the top-level MFD.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/e822c172/attachment.sig>
