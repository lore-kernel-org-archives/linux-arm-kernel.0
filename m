From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 1 Aug 2013 15:01:09 -0400
Subject: [FAILURE] omap4430-sdp allnoconfig
In-Reply-To: <20130801185956.GK8868@codeaurora.org>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
 <51FAA4C6.10203@ti.com> <20130801182707.GB23053@n2100.arm.linux.org.uk>
 <51FAA985.3000809@ti.com> <51FAAA31.6020903@codeaurora.org>
 <51FAAAFD.6000706@codeaurora.org> <51FAAD73.3030103@ti.com>
 <20130801185956.GK8868@codeaurora.org>
Message-ID: <51FAB075.4020807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 August 2013 02:59 PM, Stephen Boyd wrote:
> On 08/01, Santosh Shilimkar wrote:
>> This one looks fine for me. Can you send above in
>> a proper patch ? Let me know if you want me to
>> send it.
>>
> 
> Here's a proper patch. Olof, can you please apply this on top of
> the merge (and maybe you can fix the merge again to handle the
> HAVE_CAN problem I mentioned earlier).
> 
> ---8<---
> Subject: [PATCH] ARM: OMAP2+: Fix fallout from localtimer divorce and SMP=n
> 
> A recent patch ef3160c (ARM: OMAP2+: Divorce from local timer
> API, 2013-03-04) broke the omap build when SMP=n because the TWD
> functions are only compiled on SMP=y builds. Stub out the TWD
> calls when the TWD isn't built in to to keep everything building.
> 
> arch/arm/mach-omap2/built-in.o: In function
> `omap4_local_timer_init':
> dss-common.c:(.init.text+0x1d90): undefined reference to
> `twd_local_timer_register'
> 
> Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
Thanks Stephen
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
