From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Thu, 18 Nov 2010 11:18:45 +0100
Subject: [PATCH] ARM: add support for uncompressed uImage kernel
In-Reply-To: <20101118091046.GA16907@n2100.arm.linux.org.uk>
References: <1289310656-29502-1-git-send-email-alexander.stein@systec-electronic.com>
	<201011180838.26679.alexander.stein@systec-electronic.com>
	<20101118091046.GA16907@n2100.arm.linux.org.uk>
Message-ID: <201011181118.45476.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday 18 November 2010, 10:10:46 Russell King - ARM Linux wrote:
> On Thu, Nov 18, 2010 at 08:38:26AM +0100, Alexander Stein wrote:
> > We only have experience with GZIP. Our compressed kernel is ~1,8MB and
> > uncompressed ~4MB.
> > On an AT91 ARM9 SoC the decompression takes about 1-2s of time. Caches
> > should be disabled, as far as I could see in decompression code.
> 
> Are you sure?  ARM9 is supposed to be ARMv4T, which is covered by this
> entry in the proc_types table:
> 
>                 .word   0x00020000              @ ARMv4T
>                 .word   0x000f0000
>                 W(b)    __armv4_mmu_cache_on
>                 W(b)    __armv4_mmu_cache_off
>                 W(b)    __armv4_mmu_cache_flush
> 
> So caches _should_ be enabled.

I'm _not_ sure. That was a long time ago and I only did a short look into the 
decompression/setup code.
After I noticed using the uncompressed kernel is much faster, I didn't 
investigate further.

Best regards,
Alexander
