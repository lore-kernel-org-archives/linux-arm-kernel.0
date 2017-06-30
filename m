From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 30 Jun 2017 14:25:29 +0200
Subject: [PATCH 0/8] mailbox: arm/arm64: introduce smc triggered mailbox
In-Reply-To: <20170630095608.24943-1-andre.przywara@arm.com>
References: <20170630095608.24943-1-andre.przywara@arm.com>
Message-ID: <20170630122529.upjigip4hztrq67h@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jun 30, 2017 at 10:56:00AM +0100, Andre Przywara wrote:
> The remaining patches demonstrate usage of this feature to drive SCPI services
> implemented as part of the ARM Trusted Firmware implementation used for
> AArch64 based Allwinner SoCs, the Allwinner A64 in this example.
> It allows to provide DVFS services, sensors support, device power domains
> and potentially other services like clocks or regulators.
> This allows to abstract those features in firmware, without the need to
> implement explicit Linux support for each variant of some SoC design.
> Those DT changes are not necessarily meant to be merged at this point.
> I started implementing the firmware side of those services and put a WIP
> branch on my ATF Github repo [1]. With this branch and these patches here
> you get DVFS and temperature sensor support for the A64, just with this
> driver and the generic SCPI support.

I would go even further, and say that these changes should be done by
the bootloader itself once it installed the proper monitor.

These patches represent not a state of the hardware itself, but the
state the bootloader let the hardware in, and that state will change
from one bootloader to the other, and one version to the other
(obviously). This is already what we do for the other things the
bootloader initializes (like simplefb, or PSCI). It just feels natural
to do the same thing here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/0c9a1661/attachment.sig>
