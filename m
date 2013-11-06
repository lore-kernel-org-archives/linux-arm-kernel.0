From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 15:54:47 +0100
Subject: [PATCH 2/2] ARM: mvebu: fix second and third PCIe unit of
 Armada XP mv78260
In-Reply-To: <404b8db0e3019337ff872ca0f3b5c8eefd808525.1383681717.git.arno@natisbad.org>
References: <cover.1383681717.git.arno@natisbad.org>
 <404b8db0e3019337ff872ca0f3b5c8eefd808525.1383681717.git.arno@natisbad.org>
Message-ID: <20131106155447.598319ec@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnaud Ebalard,

On Tue, 05 Nov 2013 21:46:02 +0100, Arnaud Ebalard wrote:
> mv78260 flavour of Marvell Armada XP SoC has 3 PCIe units. The
> two first units are both x4 and quad x1 capable. The third unit
> is only x4 capable. This patch fixes mv78260 .dtsi to reflect
> those capabilities.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 109 ++++++++++++++++++++++++-------
>  1 file changed, 85 insertions(+), 24 deletions(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Same thing: this has been buggy since 3.10, but only 3.11 onwards have
the PCIe driver that uses this DT information. Therefore, pushing this
to 3.11.x and 3.12.x would be fine.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
