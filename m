From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Sep 2014 16:52:13 +0100
Subject: LPAE boot failed after commit 7fb00c2fca4b6: "ARM: 8114/1: LPAE:
 load upper bits of early TTBR0/TTBR1"
In-Reply-To: <2a4c00eb49dc4f40b3577609f1f33219@BL2PR03MB467.namprd03.prod.outlook.com>
References: <2a4c00eb49dc4f40b3577609f1f33219@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <20140904155212.GA22354@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 11:08:31AM +0100, Jingchang Lu wrote:
>   Our one ARMv7 Cortex-A7 based dual core SoC with LPAE support could not boot since next-20140811 on the linux-next tree, 
> I notice that there is a commit 7fb00c2fca4b6c58be521?, ?ARM: 8114/1: LPAE: load upper bits of early TTBR0/TTBR1?.
> Revert that commit the SoC boots successfully, do you have any suggestion on this, thanks. 
> 
>   related SoC hardware and kernel configurations are:
>        DRAM PHYS address: 0x80000000
>        CONFIG_VMSPLIT_2G
>        CONFIG_PAGE_OFFSET=0x80000000
>        CONFIG_ARM_LPAE

Does this patch fixes the problem:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8132/1

-- 
Catalin
