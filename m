From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 13:39:17 +0200
Subject: [RFC 08/17] ARM: mvebu: remove custom .init_time hook
In-Reply-To: <52173A3E.2040509@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-9-git-send-email-sebastian.hesselbarth@gmail.com>
 <52173408.1000702@free-electrons.com> <52173A3E.2040509@gmail.com>
Message-ID: <521749E5.6020008@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/08/2013 12:32, Sebastian Hesselbarth wrote:
> On 08/23/13 12:06, Gregory CLEMENT wrote:
>> On 20/08/2013 04:04, Sebastian Hesselbarth wrote:
>>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>>> remove custom .init_time hooks.
>>
>> As a feared it won't work on Armada XP. You moved coherency_init(), and
>> l2x0_of_init() in the init_machine hook. However init_machine is an
>> arch_initcall, and as all the initcall it is called at the end of the
>> do_basic_setup() which is called after smp_prepare_cpus(). The issue is
>> that smp_prepare_cpus need coherency (and I think L2 cache) already enable.
> 
> Ok, I see. I remember mvebu smp relies on mbus mappings also? Can you
> try below as replacement for the mach-mvebu/armada-370-xp.c changes?
> 
> It will move coherency_init(), l2x0_of_init(), and mvebu_mbus_dt_init()
> to .init_early hook.
> 

I can't test it, because I don't receive the patch 1 and 2 neither directly
or through linux-arm-kernel (it should have been bounced), or even at
https://github.com/shesselba/linux-dove.git

If you don't want to send them again, could you at least push our branch on your
github?

Thanks

> Sebastian
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
