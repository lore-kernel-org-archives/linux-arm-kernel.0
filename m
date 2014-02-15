From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 15 Feb 2014 04:24:30 +0300
Subject: [PATCH 0/5] Set Ether device's DMA masks on SH-Mobile boards
Message-ID: <201402150424.30954.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

   Here's the set of 5 patches against Simon Horman's 'renesas.git' repo,
'renesas-devel-v3.14-rc2-20130213' tag. Here we add still missing DMA masks
for the Ether platform devices (I was always wondering how the 'sh_eth' driver
manages to work without them :-). This should be especially important for the
Lager/Koelsch boards with their CPUs supporting LPAE and the boards having
memory outside 4 GiB address range, so we'd have to eventually enable
CONFIG_HIGHMEM for them; I also have plans to add support for NETIF_F_SG to the
'sh_eth' driver -- in which case the correct DMA masks would become important.

[1/5] ARM: shmobile: Armadillo 800 EVA: set proper DMA masks for Ether device
[2/5] ARM: shmobile: BOCK-W: set proper DMA masks for Ether device
[3/5] ARM: shmobile: Lager: set proper DMA masks for Ether device
[4/5] ARM: shmobile: Koelsch: set proper DMA masks for Ether device
[5/5] ARM: shmobile: Genmai: set proper DMA masks for Ether device

WBR, Sergei
