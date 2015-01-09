From: rabin@rab.in (Rabin Vincent)
Date: Fri, 9 Jan 2015 18:57:38 +0100
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150109175738.GA4057@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 06:11:28PM -0800, Florian Fainelli wrote:
> Enabling CPU_DCACHE_DISABLE on a SMP capable system will prevent the
> kernel from booting because of the following ldrex instruction in
> arch_spin_lock:

BTW, it's not just SMP spin_lock which uses ldrex/strex.  The atomic
ops, set_bit() and friends, and cmpxchg() and related functions all use
ldrex/strex on ARMv6+ processors, even if you disable SMP.
