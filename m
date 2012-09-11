From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 11 Sep 2012 13:10:00 +0000
Subject: [PATCH v4] Add basic address decoding support for Marvell 370/XP
In-Reply-To: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347366450-26644-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201209111310.00347.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 September 2012, Thomas Petazzoni wrote:
> Andrew, Jason, Gr?gory,
> 
> Here is a patch set that introduces basic support for address decoding
> on Armada 370 and Armada XP. The aim of this basic support is
> essentially to be able to configure a window to remap the BootROM,
> which is needed to startup the secondary CPUs for the SMP support.
> 
> As we had discussed already, the address decoding configuration is not
> described in the Device Tree, it is for now hardcoded on a per-SoC
> basis. We might later discuss how to extend this to the Device Tree.
> 
> The patch set is relatively long, as it refactors some existing
> Dove/Kirkwood/MV78xx0/Orion code to use void __iomem pointers instead
> of unsigned long, as per the request of Arnd Bergmann and Olof
> Johansson.

Excellent!

Acked-by: Arnd Bergmann <arnd@arndb.de>

Just one small comment for the very last patch:

>  (7) Patch 17 adds the necessary DT code to instantiate the address
>      decoding "controller".
> 

This one seems to lack a device tree binding document.
