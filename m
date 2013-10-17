From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 17 Oct 2013 11:07:45 +0100
Subject: [PATCH 1/2] ARM: vexpress: Make defconfig work again
In-Reply-To: <525ED182.6080505@codeaurora.org>
References: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
 <1381930594-1701-2-git-send-email-pawel.moll@arm.com>
 <525ED182.6080505@codeaurora.org>
Message-ID: <1382004465.27517.107.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-16 at 18:48 +0100, Christopher Covington wrote:
> > - disable low level debug and early printk
> > 
> > Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
> > [PM: removed DEBUG_LL - it doesn't work on qemu]
> 
> Does DEBUG_LL/EARLY_PRINTK break boot on QEMU? If not, why not leave it in for
> folks using other emulators, hardware, and maybe future versions of QEMU?

Yep, unfortunately it does break qemu boot. And generally DEBUG_LL is
considered to be a development-only option and in it was pointed out in
many discussion that people using it must exactly know what are they
doing. Definitely not a candidate for a defconfig.

As to the details of the problem, the memory map detection heuristics
has been crafted do match the V2P-CA9 board processor revision, and qemu
returns a different one. Just a nuisance, but very hard to debug if
things go wrong. And before you ask, I'd rather remove the detection
code completely than change it yet another time, which will have the
same result - no DEBUG_LL enabled in defconfig because one will have to
explicitly select one of two options. Pick the wrong one and you're back
in the same place - nothing work and you don't know where.

Thanks for looking at the patch!

Pawel
