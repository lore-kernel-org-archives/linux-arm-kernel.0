From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 7 Sep 2013 07:56:26 +0200
Subject: crypto/xor.ko fails to build with CONFIG_KERNEL_MODE_NEON=y
In-Reply-To: <CA+5PVA6iUcY+DCh51R_uwxZ1BOGrS-8-OfaFTF6Bwz9JFDVcUQ@mail.gmail.com>
References: <CA+5PVA6iUcY+DCh51R_uwxZ1BOGrS-8-OfaFTF6Bwz9JFDVcUQ@mail.gmail.com>
Message-ID: <645D2350-5007-4EFF-AFFD-8D51BA006292@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7 sep. 2013, at 04:44, Josh Boyer <jwboyer@fedoraproject.org> wrote:

> We enabled CONFIG_KERNEL_MODE_NEON on the armv7hl builds we're doing.
> It builds for a while, but eventually fails when running modpost on
> the xor.ko module:
> 
> ERROR: "xor_block_neon_inner" [crypto/xor.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 

Clearly a bug, thanks for spotting this. I will submit a fix asap. In the mean time, building the xor code into the zImage will help you complete the build.

> I tried adding an EXPORT_SYMBOL_GPL(xor_block_neon_inner); after the
> structure definition in arch/arm/lib/xor-neon.c but that doesn't seem
> to have done anything.
> 

I would expected that to have done the trick, but perhaps it is better to merge the neon code into the main arm/xor source file.

> Before I go chasing this further, I'm curious if anyone else has run into this.
> 

Cheers,
Ard.



> josh
