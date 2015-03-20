From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Mar 2015 10:07:07 -0600
Subject: [PATCH] ARM: trusted_foundations: Maintain CPU endianness
In-Reply-To: <1426865807-22981-1-git-send-email-digetx@gmail.com>
References: <1426865807-22981-1-git-send-email-digetx@gmail.com>
Message-ID: <550C45AB.3070703@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2015 09:36 AM, Dmitry Osipenko wrote:
> Convert CPU reset vector address to LE to support big-endian kernel.

Naively this sounds a little odd; the value here is in a CPU register 
all the time, not in memory, so I'm not sure why endianness is relevant? 
Presumably the CPU doesn't end up byte-swapping values in registers when 
running in BE mode or it takes an SMC? If it does, why don't we need 
cpu_to_le32(TF_SET_CPU_BOOT_ADDR_SMC) too?

Sorry if this is a silly question; I haven't followed any of the BE 
kernel patches.
