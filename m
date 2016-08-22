From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 22 Aug 2016 12:23:31 +0200
Subject: [PATCH v6 2/8] power: add power sequence library
In-Reply-To: <20160822065158.GB4362@shlinux2>
References: <1471252398-957-1-git-send-email-peter.chen@nxp.com>
 <1471252398-957-3-git-send-email-peter.chen@nxp.com>
 <20160822065158.GB4362@shlinux2>
Message-ID: <20160822102331.bimz22w6z2v65jd7@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Mon, Aug 22, 2016 at 02:51:58PM +0800, Peter Chen wrote:
> On Mon, Aug 15, 2016 at 05:13:12PM +0800, Peter Chen wrote:
> > We have an well-known problem that the device needs to do some power
> > sequence before it can be recognized by related host, the typical
> > example like hard-wired mmc devices and usb devices.
> > 
> > This power sequence is hard to be described at device tree and handled by
> > related host driver, so we have created a common power sequence
> > library to cover this requirement. The core code has supplied
> > some common helpers for host driver, and individual power sequence
> > libraries handle kinds of power sequence for devices.
> > 
> > pwrseq_generic is intended for general purpose of power sequence, which
> > handles gpios and clocks currently, and can cover regulator and pinctrl
> > in future. The host driver calls pwrseq_alloc_generic to create
> > an generic pwrseq instance.
> > 
> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
> > Tested-by Joshua Clayton <stillcompiling@gmail.com>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Hi Greg, Sebastian, Dmitry, and David
> 
> I find the code under drivers/power have several subsystems.
> Does this power sequence patch set can go git://git.infradead.org/battery-2.6.git?
> Or can go the Greg's tree?

I think this does not really fit into the power-supply tree.
I would expect this to go through Rafael's linux-pm tree.

Note: I moved all the power-supply code into drivers/power/supply/
in linux-next, among other things because of this patchset. To avoid
merge conflicts in drivers/power/Makefile and drivers/power/Kconfig
the tree pulling this patchset should also pull a (yet to be
created) immutable branch containing
https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/commit/drivers/power?h=for-next&id=8c0984e5a75337df513047ec92a6c09d78e3e5cd

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160822/295a0449/attachment.sig>
