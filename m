From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Jan 2013 17:08:43 +0000
Subject: [PATCH 0/3] arch_decomp_wdog cleanup
In-Reply-To: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
References: <1357827165-9320-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130111170843.GG23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 10:12:42PM +0800, Shawn Guo wrote:
> All the arch_decomp_wdog related codes are there without any users,
> since ARCH_HAS_DECOMP_WDOG is only used by lib/inflate.c which however
> is not used by arch/arm/boot/compressed/decompress.c.

Hmm, this suggests that those samsung platforms haven't been booted for
a while - because the decompressor will enable the watchdog, but won't
pat it at all.  So, do we still need them in the kernel?

Other than that, this looks good.  Who's going to deal with it though?
