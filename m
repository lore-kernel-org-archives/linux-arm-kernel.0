From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 22 Dec 2015 14:31:15 -0800
Subject: [PATCH v11 0/2] Sigma Designs Tango4 port
In-Reply-To: <5679C743.1070000@free.fr> (Mason's message of "Tue, 22 Dec 2015
 22:57:23 +0100")
References: <566FDF53.3030004@sigmadesigns.com>
 <7hr3iexp3e.fsf@deeprootsystems.com> <5679B15F.80106@free.fr>
 <7hoadi6wfw.fsf@deeprootsystems.com> <5679C743.1070000@free.fr>
Message-ID: <7h60zqund8.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mason <slash.tmp@free.fr> writes:

> On 22/12/2015 21:49, Kevin Hilman wrote:
>
>> Mason wrote:
>> 
>>> On 22/12/2015 20:25, Kevin Hilman wrote:
>>>
>>>> Was it intentional to leave out a multi_v7_defconfig change so that this
>>>> actually builds?  Or was that planned for a future series?
>>>
>>> How is a multi_v7_defconfig different from any old defconfig?
>> 
>> Not sure what you're asking.
>> 
>> The point is that this series doesn't enable any defconfig to build it.
>
> What is not clear to me is: are you asking me to submit a new defconfig
> (specific to my platform), or are you saying I need to add the new
> platform to arch/arm/configs/multi_v7_defconfig

multi_v7_defconfig, which is what I've been assuming you've been testing
it with.  Is that correct?

> (I'm not sure how exactly
> to go about doing that; also I'm concerned about merge conflicts, since
> my patch set is based on v4.1)

The latter.  Something like below[1].  Just keep the multi_v7_defconfig
patch as a separate patch, and we'll take care of the merge conflicts
when applying to the relevant arm-soc branches.

>
>>>> IMO, it should be part of this series so it gets build tested as soon as
>>>> it's merged.
>>>
>>> The problem is that a mandatory driver is missing upstream
>>> (interrupt controller).
>>>
>>> http://thread.gmane.org/gmane.linux.kernel/2089470
>> 
>> Which means it presumably wont boot without that, but it should still
>> build without it, correct?  (I tried it locally, and it does.)
>
> Can I submit the defconfig update as a follow-up patch?

IMO, it should be part of this series that adds the platform.  That way,
as soon as it gets merged, it will be automatically build tested by
various automated builders.  (also note that it would be automatically
boot tested if I had the hardware as well... hint, hint) ;)

Kevin

[1]
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fdb52a5..d5aa59b148da 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -89,6 +89,7 @@ CONFIG_ARCH_R8A7794=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_SIRF=y
+CONFIG_ARCH_TANGO=y
 CONFIG_ARCH_TEGRA=y
 CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
