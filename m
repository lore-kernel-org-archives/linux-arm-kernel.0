From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 18 Aug 2010 11:54:58 +0800
Subject: several section mismatches
In-Reply-To: <op.vgyj74zp7p4s8u@pikus>
References: <201008021121.23860.sleep_walker@suse.cz> <op.vgyj74zp7p4s8u@pikus>
Message-ID: <AANLkTimhT0FW17Xf0avwAZUee6EQ0N=v86xAoAC7YBae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A simple fix to cpufreq for pxa would be as below:

diff --git a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
index 268a9bc..50d5939 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa2xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa2xx.c
@@ -398,7 +398,7 @@ static int pxa_set_target(struct cpufreq_policy *policy,
 	return 0;
 }

-static __init int pxa_cpufreq_init(struct cpufreq_policy *policy)
+static int pxa_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int i;
 	unsigned int freq;
diff --git a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
index 27fa329..0a0d0fe 100644
--- a/arch/arm/mach-pxa/cpufreq-pxa3xx.c
+++ b/arch/arm/mach-pxa/cpufreq-pxa3xx.c
@@ -204,7 +204,7 @@ static int pxa3xx_cpufreq_set(struct cpufreq_policy *policy,
 	return 0;
 }

-static __init int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
+static int pxa3xx_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret = -EINVAL;


On Thu, Aug 5, 2010 at 5:20 PM, Micha? Nazarewicz
<m.nazarewicz@samsung.com> wrote:
> On Mon, 02 Aug 2010 11:21:23 +0200, Tom?? 'Sleep_Walker' ??ech
> <sleep_walker@suse.cz> wrote:
>>
>> It seems that we have some problems with g_ether and pxa cpufreq.
>> This is problematic output of `make CONFIG_DEBUG_SECTION_MISMATCH=y':
>
> Problems with g_ether should be fixed in -next.
>
> --
> Best regards, ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?_ ? ? _
> | Humble Liege of Serenely Enlightened Majesty of ?o' \,=./ `o
> | Computer Science, ?Micha? "mina86" Nazarewicz ? ? ? (o o)
> +----[mina86*mina86.com]---[mina86*jabber.org]----ooO--(_)--Ooo--
>
