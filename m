From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 05:35:00 +0000
Subject: [PATCH v5 06/14] ARM: OMAP2+: gpmc: CS configuration helper
In-Reply-To: <4FD78519.2080409@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <9dd458171d6a68ea4f97a4ba19dbacc0d6b5ba35.1339419492.git.afzal@ti.com>
 <4FD66666.8060002@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F1F@DBDE01.ent.ti.com>
 <4FD78519.2080409@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998800@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 23:36:17, Hunter, Jon wrote:

> Well it is unclear what the code flow is for using this helper as this
> change simply adds the helper. If someone other function is writing to
> the CONFIG1 register before this function, then you may wish to
> highlight the programming sequence in the changelog or at least describe
> why this function performs a read-modify-write and not just a write.

Logic followed here: CS configuration helper needs to worry only about
bits that are relevant for CS configuration and don't alter any other
bits/registers.

Same is applicable for time setting helper.

Regards
Afzal
