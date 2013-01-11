From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 11:22:38 -0800
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <20130111170843.GG23505@n2100.arm.linux.org.uk>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
 <20130111170843.GG23505@n2100.arm.linux.org.uk>
Message-ID: <20130111192238.GB1148@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 11, 2013 at 05:08:43PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 10, 2013 at 10:12:42PM +0800, Shawn Guo wrote:
> > All the arch_decomp_wdog related codes are there without any users,
> > since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
> > is not used by arch/arm/boot/compressed/decompress.c.
> 
> Hmm, this suggests that those samsung platforms haven't been booted for
> a while - because the decompressor will enable the watchdog, but won't
> pat it at all.  So, do we still need them in the kernel?

Well, they haven't been booted with the watchdog enabled at least.

> Other than that, this looks good.  Who's going to deal with it though?

Given that it touches include files under mach-*/include, we might be better
off taking it through arm-soc from conflicts point of view. Ok with you?

-Olof
