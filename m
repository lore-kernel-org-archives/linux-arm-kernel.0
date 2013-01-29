From: david.woodhouse@intel.com (Woodhouse, David)
Date: Tue, 29 Jan 2013 15:10:43 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <5107E285.8060304@gmail.com>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <5107E285.8060304@gmail.com>
Message-ID: <1359472241.3529.129.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 08:53 -0600, Rob Herring wrote:
> If you specify to use the builtin's, do you still get inline rev
> instructions emitted?

You mean from the architecture's __arch_swab32() et al. macros?

No. If the architecture enables ARCH_USE_BUILTIN_BSWAP and the compiler
version checks indicate that the correspondingly-sized builtin is
available, then the builtin will be used. Only if the arch *doesn't* set
ARCH_USE_BUILTIN_BSWAP, or if the compiler is old enough not to have the
corresponding intrinsic, will the inline assembler in the __arch_swabXX
macros get used.

Note, however, that there is no such compiler intrinsic for swahb32(),
which is where rev16 gets used. That's still being left to the inline
asm in all cases.

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/cac8d645/attachment.bin>
