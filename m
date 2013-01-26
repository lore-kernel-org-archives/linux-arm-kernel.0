From: mario.schuknecht@dresearch-fe.de (Mario Schuknecht)
Date: Sat, 26 Jan 2013 17:30:30 +0000 (UTC)
Subject: [PATCH] dma: =?utf-8?b?bXZfeG9yOg==?= remove minimal offload
 length threshold
References: <1356636037-22948-1-git-send-email-lkundrak@v3.sk>
 <1356639358.28655.7.camel@sakura.staff.proxad.net>
Message-ID: <loom.20130126T182854-381@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Bizon <mbizon <at> freebox.fr> writes:

> 
> On Thu, 2012-12-27 at 20:20 +0100, Lubomir Rintel wrote:
> > 
> > of memory condition and retries indefinitelly, causing a soft lockup.
> > The threshold does not seem to be enforced by hardware (couldn't find
> > anything like that in a datasheet)
> 
> page 212
> 
> Table 63: Descriptor Byte Count Word
> 
> 3:0 ByteCount
> 
> XOR mode: Size of source and destination blocks in bytes.
> CRC mode: Size of source block part represented by the descriptor.
> DMA mode: Size of source and destination block in bytes.
> Minimum blocks' size: 16B.
> Maximum blocks' size: 16MB-1
> 
> > and things seems to work fine without it. If there's a 
> 
> my guess is that it transfers 16B so it seems to work but actually
> corrupts data.
> 
> maybe we should teach net_dma_find_channel() about that limitation 
> 

I observe the same error with the Marvell SoC 88F6282. The patch works. It is 
sufficient to just change the #define MV_XOR_MIN_BYTE_COUNT of 128 to 16. But 
I'm not very familiar with the code and Marvell xor/dma engine.
Therefore the questions: Is the patch correctly for the SoC 88F6282? Is the 
error still in work? And is there an offical solution soon?

Kind regards,

Mario Schuknecht
