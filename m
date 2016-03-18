From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 18 Mar 2016 16:52:03 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318154500.GJ19428@n2100.arm.linux.org.uk>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
 <87oaab980n.fsf@free-electrons.com>
 <20160318144639.GH19428@n2100.arm.linux.org.uk>
 <20160318163518.122505a5@free-electrons.com>
 <20160318154500.GJ19428@n2100.arm.linux.org.uk>
Message-ID: <20160318165203.4512ed1d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 18 Mar 2016 15:45:00 +0000, Russell King - ARM Linux wrote:

> I do seem to be carrying some patches for some time for CESA:
> 
> crypto: marvell: rearrange handling for sw padded hashes
> crypto: marvell: rearrange handling for hw finished hashes
> crypto: marvell: rearrange last request handling
> crypto: marvell: avoid adding final operation within loop
> crypto: marvell: ensure iter.base.op_len is the full op length
> crypto: marvell: use presence of scatterlist to determine data load
> crypto: marvell: move mv_cesa_dma_add_frag() calls
> crypto: marvell: always ensure mid-fragments after first-fragment
> crypto: marvell: factor out adding an operation and launching it
> crypto: marvell: factor out first fragment decisions to helper
> crypto: marvell: const-ify argument to mv_cesa_get_op_cfg()
> crypto: marvell: ensure template operation is initialised
> crypto: marvell: fix the bit length endianness
> crypto: marvell: add flag to determine algorithm endianness
> crypto: marvell: keep creq->state in CPU endian format at all times
> crypto: marvell: easier way to get the transform
> 
> and the last time I seem to have any comments on them was back in
> October last year.  I don't remember what status these are, and as I've
> been concentrating on other areas.  I'll try to remember to send them
> out after rc1.

All (or most) of these patches seem to be in mainline already:

ab270e7055e0aa9d4dc3bf419cdfdde340174978 crypto: marvell/cesa - rearrange handling for sw padded hashes
aee84a7e6ed515f0f217317ff261a15db4bff0bb crypto: marvell/cesa - rearrange handling for hw finished hashes
58953e15ef015ba9136b7234a7098cf827428999 crypto: marvell/cesa - rearrange last request handling
e41bbebddec44f7c06585f42686b2a529513fc6a crypto: marvell/cesa - avoid adding final operation within loop
bd274b10856b91f702fa767114aa7e6ac45b933d crypto: marvell/cesa - ensure iter.base.op_len is the full op length
d9bba4c3ebbc65b9113624eb1690bed776fb6106 crypto: marvell/cesa - use presence of scatterlist to determine data load
0971d09a8566abd6640acdbe3fd304e67e257bd3 crypto: marvell/cesa - move mv_cesa_dma_add_frag() calls
2f396a91d1d01a423fd87b7c6ff71600d06b9c05 crypto: marvell/cesa - always ensure mid-fragments after first-fragment
9621288673cb2a1805eadf29b92e5bcec6a0e2e5 crypto: marvell/cesa - factor out adding an operation and launching it
8651791e5403a0e0634b76dee91b102dc4f40385 crypto: marvell/cesa - factor out first fragment decisions to helper
c439e4eec73373c6d5b7129ece69d67978ada307 crypto: marvell/cesa - const-ify argument to mv_cesa_get_op_cfg()
d30cb2fa34829161cfa1f847049b3fcfcfeebc93 crypto: marvell/cesa - ensure template operation is initialised
51954a968bbedcabf2b42fec2ec51386f0dee0c4 crypto: marvell/cesa - fix the bit length endianness
a9eb678f8addc1bfb80bacc45f6df1108fd1c0d9 crypto: marvell/cesa - add flag to determine algorithm endianness
4c2b130c8ae79af734e5e57f3662e25ef4d20e8d crypto: marvell/cesa - keep creq->state in CPU endian format at all times
80754539ec936b0afe8a3c406b7d67612977cc71 crypto: marvell/cesa - easier way to get the transform

They are in mainline since v4.4.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
