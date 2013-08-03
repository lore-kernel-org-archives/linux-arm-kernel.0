From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Aug 2013 23:32:03 -0400 (EDT)
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <51F95813.2060508@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
 <51F95813.2060508@ti.com>
Message-ID: <alpine.LFD.2.03.1308022329121.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Aug 2013, Sricharan R wrote:

> Just, had another way of implementing this without using the
> 'opcodes'. By adding a additional data in the stub which would identify
> the previous instruction instead of using opcodes. This can make the
> patching code little simpler.
> Incase, if using opcodes is not good. Like this,
> 
> #define PATCH_ADDS      0
> #define PATCH_ADDC      1

No.  In general the patching code doesn't need to care about the 
instruction being patched.  It only needs to know what value to patch 
in.  See my previous email.



Nicolas
