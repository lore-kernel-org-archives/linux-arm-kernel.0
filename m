From: nsekhar@ti.com (Nori, Sekhar)
Date: Tue, 17 Jan 2012 19:56:27 +0000
Subject: [PATCH v2] DaVinci: can only power up domains on DM644x
In-Reply-To: <3E54258959B69E4282D79E01AB1F32B7265471@DFLE34.ent.ti.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
 <201201062140.33712.sshtylyov@ru.mvista.com>
 <201201062148.32025.sshtylyov@ru.mvista.com>
 <3E54258959B69E4282D79E01AB1F32B7265471@DFLE34.ent.ti.com>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6317939DA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Jan 12, 2012 at 17:30:15, Karicheri, Muralidharan wrote:
> Sekhar & Sergei,
> 
> This will affect the new SoCs that have capabilities to power up different domains. Why do we need this enforcement? We are working on a DaVinci variant SoC that can do power up multiple domains (That is why I had a patch earlier to support
> Multiple PD which is already part of the tree). So I don't want this patch to go through unless I see a reason for pushing this.

I agree with Murali here. The cpu_is_ checking in the patch
is going to quickly turn ugly as new SoCs with power domain
control are added.

On SoCs where domain power up procedure is not documented,
even bootloader cannot be responsible for powering up the
domain. The domain will be powered up in hardware itself;
so the power domain status cannot show the domain as powered
off.

A better change in this area would be to add a timeout to the
infinite loop reading epcpr. This will enable proper error
reporting.

Thanks,
Sekhar
