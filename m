From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jun 2012 16:43:34 +0100
Subject: [RFC PATCH 1/2] ARM: use generic strnlen_user and
 strncpy_from_user functions
In-Reply-To: <1339169935-31775-2-git-send-email-will.deacon@arm.com>
References: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
 <1339169935-31775-2-git-send-email-will.deacon@arm.com>
Message-ID: <20120608154334.GB3563@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 08, 2012 at 04:38:54PM +0100, Will Deacon wrote:
> This patch implements the word-at-a-time interface for ARM using the
> same algorithm as x86. Although we have a clz instruction from ARMv5,
> this only saves us one mov instruction when building with Thumb-2 and
> makes no difference when targetting ARM, so we use the magic 0x0ff0001
> constant for all CPUs. For big-endian configurations, we use the
> implementation from asm-generic.

Damn, I forgot to update this comment. I decided that it was worth getting
rid of the mov since it's fairly clean using the fls macro, so we do emit
a clz instruction on ARMv5 and later.

Will
