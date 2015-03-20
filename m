From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 20 Mar 2015 19:41:37 +0300
Subject: [PATCH] ARM: trusted_foundations: Maintain CPU endianness
In-Reply-To: <550C45AB.3070703@wwwdotorg.org>
References: <1426865807-22981-1-git-send-email-digetx@gmail.com>
 <550C45AB.3070703@wwwdotorg.org>
Message-ID: <550C4DC1.3090909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

20.03.2015 19:07, Stephen Warren ?????:
> On 03/20/2015 09:36 AM, Dmitry Osipenko wrote:
>> Convert CPU reset vector address to LE to support big-endian kernel.
>
> Naively this sounds a little odd; the value here is in a CPU register all the
> time, not in memory, so I'm not sure why endianness is relevant? Presumably the
> CPU doesn't end up byte-swapping values in registers when running in BE mode or
> it takes an SMC? If it does, why don't we need
> cpu_to_le32(TF_SET_CPU_BOOT_ADDR_SMC) too?
>
> Sorry if this is a silly question; I haven't followed any of the BE kernel patches.

You absolutely right. I goofed it by replacing 'smc' with 'str' without adding 
reg reverse for BE when was testing and then blindly made patch. Please ignore 
it and sorry for the noise.

-- 
Dmitry
