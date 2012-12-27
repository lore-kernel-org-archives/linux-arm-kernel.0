From: mbizon@freebox.fr (Maxime Bizon)
Date: Thu, 27 Dec 2012 21:15:58 +0100
Subject: [PATCH] dma: mv_xor: remove minimal offload length threshold
In-Reply-To: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
References: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
Message-ID: <1356639358.28655.7.camel@sakura.staff.proxad.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-27 at 20:20 +0100, Lubomir Rintel wrote:
> 
> of memory condition and retries indefinitelly, causing a soft lockup.
> The threshold does not seem to be enforced by hardware (couldn't find
> anything like that in a datasheet)

page 212

Table 63: Descriptor Byte Count Word

3:0 ByteCount

XOR mode: Size of source and destination blocks in bytes.
CRC mode: Size of source block part represented by the descriptor.
DMA mode: Size of source and destination block in bytes.
Minimum blocks' size: 16B.
Maximum blocks' size: 16MB-1

> and things seems to work fine without it. If there's a 

my guess is that it transfers 16B so it seems to work but actually
corrupts data.

maybe we should teach net_dma_find_channel() about that limitation 

-- 
Maxime
