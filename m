From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Mar 2013 11:02:05 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
References: <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
 <20130312155749.GA1820@obsidianresearch.com>
 <20130312203819.GA23221@avionic-0098.mockup.avionic-design.de>
 <20130312210328.GA22702@obsidianresearch.com>
 <20130312213006.GA23717@avionic-0098.mockup.avionic-design.de>
 <20130312220854.GA23112@obsidianresearch.com>
 <20130313081815.GD25940@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130313170205.GB24042@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 13, 2013 at 09:18:15AM +0100, Thierry Reding wrote:

> Mitch already answered this. The specification is now almost 15 years
> old and it couldn't possibly have foreseen all of the future use-cases.
> If the specification is too restrictive and Mitch gives his blessing to
> remove some of the restrictions, I don't see any reason why we shouldn't
> do so if it lets us represent the reality of hardware more accurately in
> DT.

I understand the spec is old, and I have no problem with making a
Linux specific revision, but do *that* - don't bury some random
deviation inside the bindings for a driver. I even suggested some
language, but I feel more thought is needed to consider how to model
the standardized ECAM mechanism..

> Furthermore we're not discussing radical changes. None of the changes
> will be backwards-incompatible, but they will allow recent hardware to
> be represented more correctly or conveniently.

Sure, but it is still inconsistent, one MMIO config mechansim is in
ranges, one is in regs. Plus I don't think tegra's case is a great
starting point to design a spec update, it's config access mechanism
is especially strange...

Anyhow, I think this has been hashed to death, as long as your final
binding has the 'device_type = pci' on the pcie-controller node I
think it will be fine.

Jason
