From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Dec 2011 15:42:19 +0000
Subject: [Android-virt] [Embeddedxen-devel] [Xen-devel] [ANNOUNCE] Xen
 port to Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <20111201151043.GG27394@arm.com>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
 <1322735197.31810.191.camel@zakaz.uk.xensource.com>
 <20111201151043.GG27394@arm.com>
Message-ID: <201112011542.19377.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 December 2011, Catalin Marinas wrote:
> Given the way register banking is done on AArch64, issuing an HVC on a
> 32-bit guest OS doesn't require translation on a 64-bit hypervisor. We
> have a similar implementation at the SVC level (for 32-bit user apps on
> a 64-bit kernel), the only modification was where a 32-bit SVC takes a
> 64-bit parameter in two separate 32-bit registers, so packing needs to
> be done in a syscall wrapper.

How do you deal with signed integer arguments passed into SVC or HVC from
a caller? If I understand the architecture correctly, the upper
halves of the argument register end up zero-padded, while the callee
expects sign-extension.

	Arnd
