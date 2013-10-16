From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Oct 2013 16:08:22 +0100
Subject: at91sam9g20-ek pinctrl conflicts
In-Reply-To: <20131016120617.GB27808@ns203013.ovh.net>
References: <20131016110405.GH2443@sirena.org.uk>
 <20131016120617.GB27808@ns203013.ovh.net>
Message-ID: <20131016150822.GN2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 02:06:17PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 12:04 Wed 16 Oct     , Mark Brown wrote:

> > pinctrl-at91 pinctrl.2: pin pioA1 already requested by fffc8000.spi; cannot claim for fffa8000.mmc
> > pinctrl-at91 pinctrl.2: pin-1 (fffa8000.mmc) status -22
> > pinctrl-at91 pinctrl.2: could not request pin 1 (pioA1) from group mmc0_slot1_cmd_dat0-0  on device pinctrl.2

> it's not really an error as the hw support both but not at the same time

No, I think it is an error - if only one can be enabled at once the
device tree should accurately describe this (preferrably with comments
to help identify how the configurations are selected).  Based on your
description it seems like right now the current DT is breaking the MMC
since the hardware is in the default configuration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131016/dc9259da/attachment.sig>
