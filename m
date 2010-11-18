From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Nov 2010 09:10:46 +0000
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <201011180838.26679.alexander.stein@systec-electronic.com>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<20101109140455.GA6680@n2100.arm.linux.org.uk>
	<AANLkTi=6OE=50EExgkay2ycuSPFsOp4E-RmxkNktK_Xk@mail.gmail.com>
	<201011180838.26679.alexander.stein@systec-electronic.com>
Message-ID: <20101118091046.GA16907@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 18, 2010 at 08:38:26AM +0100, Alexander Stein wrote:
> We only have experience with GZIP. Our compressed kernel is ~1,8MB and 
> uncompressed ~4MB.
> On an AT91 ARM9 SoC the decompression takes about 1-2s of time. Caches should 
> be disabled, as far as I could see in decompression code.

Are you sure?  ARM9 is supposed to be ARMv4T, which is covered by this
entry in the proc_types table:

                .word   0x00020000              @ ARMv4T
                .word   0x000f0000
                W(b)    __armv4_mmu_cache_on
                W(b)    __armv4_mmu_cache_off
                W(b)    __armv4_mmu_cache_flush

So caches _should_ be enabled.
