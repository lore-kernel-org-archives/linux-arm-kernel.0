From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 30 Jun 2011 16:04:07 -0300
Subject: [PATCH 1/1] net/fec: iMX53 needs gasket for both MII and RMII
In-Reply-To: <4E0BAC50.3030007@boundarydevices.com>
References: <1309387098-30680-1-git-send-email-troy.kisky@boundarydevices.com>
	<4E0BAC50.3030007@boundarydevices.com>
Message-ID: <BANLkTimSkDOQDZ=K1Y+qeiG91cSEmXuGMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2011 at 7:50 PM, Troy Kisky
<troy.kisky@boundarydevices.com> wrote:
> On 6/29/2011 3:38 PM, Troy Kisky wrote:
>> Currently, only RMII interfaces are using the gasket.
>> But, the iMX53 needs to enable the gasket for MII
>> mode as well. The iMX51 has no gasket registers. So,
>> add a use_gasket field to fec_platform_data to not restrict
>> same kernel for both iMX51/53 boards.
>>
>> iMX28 boards don't need use_gasket, as they have
>> FEC_QUIRK_ENET_MAC.
>> ---
>> ?arch/arm/mach-mx5/board-mx50_rdp.c ?| ? ?1 +
>> ?arch/arm/mach-mx5/board-mx53_evk.c ?| ? ?1 +
>> ?arch/arm/mach-mx5/board-mx53_loco.c | ? ?1 +
>> ?arch/arm/mach-mx5/board-mx53_smd.c ?| ? ?1 +
>> ?drivers/net/fec.c ? ? ? ? ? ? ? ? ? | ? 11 ++++++++---
>> ?include/linux/fec.h ? ? ? ? ? ? ? ? | ? ?1 +
>> ?6 files changed, 13 insertions(+), 3 deletions(-)

I think you should split your patch: one for the driver part and
another for the board files.

You should copy linux-netdev mailing list when posting
drivers/net/fec.c related changes.

Regards,

Fabio Estevam
