From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 12 Mar 2013 09:57:49 -0600
Subject: [PATCH 24/32] pci: PCIe driver for Marvell Armada 370/XP systems
In-Reply-To: <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
References: <513A7845.6040304@firmworks.com>
 <20130309013152.GA3883@obsidianresearch.com>
 <513C117D.6080800@firmworks.com>
 <20130310065539.GA14704@obsidianresearch.com>
 <513D6F9C.9000100@firmworks.com>
 <20130311181554.GA10992@obsidianresearch.com>
 <513E519B.6010503@firmworks.com>
 <20130311232516.GA13873@obsidianresearch.com>
 <513E6AFE.3090304@firmworks.com>
 <20130312070852.GA6727@avionic-0098.mockup.avionic-design.de>
Message-ID: <20130312155749.GA1820@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 08:08:52AM +0100, Thierry Reding wrote:

> So to recapitulate, we agree that configuration space can be translated
> through the "ranges" property. That means the only missing link is a new
> function to translate not only "assigned-addresses" but also the "reg"
> property for PCI devices. Is that it?

No, the first conclusion is that placing a config space in ranges is
against the language in the current spec (see section 12).

The second conclusion is that there is probably a way forward to
update the spec in a backwards compatible way to model ECAM, but would
require more analysis.

Finally, there was no objections to the approach in Thomas's patch,
other than the note to fix the '@1,0' and the extra device_type="pci"
..

> And for Marvell the non-configuration-space per-root-port registers need
> to be mapped separately from the configuration space windows?

No, there are no configuration space windows on Marvell, so only one mapping.

Regards,
Jason
