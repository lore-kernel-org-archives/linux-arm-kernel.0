From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 16 Aug 2012 09:28:39 -0400
Subject: [v3] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1344246141-23931-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20120816132839.GO22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 11:42:16AM +0200, Thomas Petazzoni wrote:
> Andrew, Jason, Gr?gory,
> 
> Here is a small patch set that introduces basic support for address
> decoding on Armada 370 and Armada XP. The aim of this basic support is
> essentially to be able to configure a window to remap the BootROM,
> which is needed to startup the secondary CPUs for the SMP support.
> 
> As we had discussed already, the address decoding configuration is not
> described in the Device Tree, it is for now hardcoded on a per-SoC
> basis. We might later discuss how to extend this to the Device Tree.
> 
> This patch set has five patches:
> 
>  (*) First patch reworks the addr-map code to use void __iomem * where
>      appropriate instead of u32, as per the suggestion of Arnd
>      Bergmann.
> 
>  (*) Second patch introducing PLAT_ORION_LEGACY, which allows the
>      Marvell 370/XP platforms to be part of PLAT_ORION, and therefore
>      re-use the existing address decoding code.
> 
>  (*) Third patch making a small change to an address decoding
>      structure so that we can define at runtime the virtual address of
>      the configuration registers. This is needed as on Armada 370/XP
>      the address decoding "controller" is declared in the Device Tree.
> 
>  (*) Fourth patch adding the 370/XP address decoding code itself. For
>      now, it only maps the BootROM on Armada XP.
> 
>  (*) Fifth path adding the necessary DT code to instantiate the
>      address decoding "controller".
> 
> Changes since v2:
>  * Remove one more useless (void __iomem *) cast in the Armada 370/XP
>    addr-map.c file, as noticed by Arnd Bergmann.
> 
> Changes since v1:
>  * Use void __iomem * in addr-map code. Suggested by Arnd Bergmann.
>  * Add Acked-by on patches 2->5 from Gr?gory Cl?ment

Whole series applied to:

git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7

thx,

Jason.
