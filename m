From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 12 Feb 2014 18:58:52 +0400
Subject: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
In-Reply-To: <52FB8526.9000601@codethink.co.uk>
References: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
 <52FB5FC0.3010808@codethink.co.uk> <52FB7642.4000506@cogentembedded.com>
 <52FB8526.9000601@codethink.co.uk>
Message-ID: <52FB8C2C.1050909@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-02-2014 18:28, Ben Dooks wrote:

>>>> Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
>>>> 'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA
>>>> addressing
>>>> ability.  Currently, the code works without DMA masks but in the
>>>> future, when
>>>> support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the
>>>> 'sh_eth' driver,
>>>> the DMA masks should start to matter...

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>> Hi, do you have a git branch available with all the changes for getting
>>> ethernet working on rcar please?

>>     Depends on whether you want it working via DT or mere platform
>> devices. If the second, it's 3.14-rc1. If DT, I don't have a branch,
>> only several patches to apply atop of the current 'renesas.git' repo's
>> 'devel' branch that I've posted last week (note that only R8A779x is
>> currently supported by these patches and NFS boot timeout is still an
>> issue with them).

> ok, I have a slightly earlier version which seems to work with nfs
> boot for me.

    There's no "slightly earlier version" (unless you mean DT support for 
BOCK-W posted months ago). Issue with NFS is not fatal, it boots fine, just 
somewhat slow.

WBR, Sergei
