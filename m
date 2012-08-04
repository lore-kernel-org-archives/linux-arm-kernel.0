From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 4 Aug 2012 03:04:56 -0400 (EDT)
Subject: [PATCH 09/22] ARM: LPAE: use 64-bit pgd physical address in
 switch_mm()
In-Reply-To: <1343775898-28345-10-git-send-email-cyril@ti.com>
References: <1343775898-28345-1-git-send-email-cyril@ti.com>
 <1343775898-28345-10-git-send-email-cyril@ti.com>
Message-ID: <alpine.LFD.2.02.1208040259200.5231@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jul 2012, Cyril Chemparathy wrote:

> This patch modifies the switch_mm() processor functions to use 64-bit
> addresses.  We use u64 instead of phys_addr_t, in order to avoid having config
> dependent register usage when calling into switch_mm assembly code.
> 
> The changes in this patch are primarily adjustments for registers used for
> arguments to switch_mm.  The few processor definitions that did use the second
> argument have been modified accordingly.
> 
> Arguments and calling conventions aside, this patch should be a no-op on v6
> and non-LPAE v7 processors. 

NAK.

You just broke all big endian targets, LPAE or not.


Nicolas
