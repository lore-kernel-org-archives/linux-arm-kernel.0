From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Nov 2013 17:14:45 +0000
Subject: [PATCH] ARM: move firmware_ops to drivers/firmware
In-Reply-To: <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
References: <1384678169-28228-1-git-send-email-acourbot@nvidia.com>
 <CAHkRjk5LBOFx3ir49RgEsaFwvp5UCpTjYFWto+URXebAsOP0RA@mail.gmail.com>
Message-ID: <20131118171445.GI16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 17, 2013 at 03:59:04PM +0000, Catalin Marinas wrote:
> No L2x0 (L210, L220, PL310) cache on ARMv8. And here I strongly
> recommend the hardware people to make proper external caches which can
> be flushed by standard CPU instructions, not MMIO. Any such caches
> must be enabled by firmware before Linux starts.

Yea, and we've seen what a trainwreck that causes on 32-bit ARM with
the kernel exploding at boot time because of a dirty L2 cache.
