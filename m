From: nsekhar@ti.com (Nori, Sekhar)
Date: Mon, 30 Aug 2010 17:28:12 +0530
Subject: [PATCH] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <4C78FA26.4040801@criticallink.com>
References: <4C78FA26.4040801@criticallink.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6615555@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sat, Aug 28, 2010 at 17:29:34, Michael Williamson wrote:
> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
> on the da850 davinci CPU architecture.  Information on these SOMs may be
> found at http://www.mitydsp.com.
>
> Basic support for the console UART, NAND, and EMAC (MII interface) is
> included in this patch.
>
> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> Notes:
>   1) Patch is against 0a50e05b20f3c6af67656303bdb3661a2541ce03 of Kevin's
>      tree (2.6.36-rc2).
>   2) I did not include a defconfig update in this patch.  Until the regulator
>      support is added back in (planned subsequent patch), it cannot be added
>      to da8xx_omapl_defconfig as the CONFIG_REGULATOR option doesn't play
>      nice with platforms not defining a regulator.  If a defconfig support

What is the issue you are facing? I have seen in the past that enabling
CONFIG_REGULATOR_DUMMY helped overcome an aic3x codec initialization issue
when the aic3x probe expects a few regulators to be present in the system
if CONFIG_REGULATOR is on.

Thanks,
Sekhar
