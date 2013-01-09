From: robherring2@gmail.com (Rob Herring)
Date: Wed, 09 Jan 2013 14:39:36 -0600
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <201301092022.49130.arnd@arndb.de>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301091843.48942.arnd@arndb.de>
 <alpine.LFD.2.02.1301091349390.6300@xanadu.home>
 <201301092022.49130.arnd@arndb.de>
Message-ID: <50EDD588.3040603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 02:22 PM, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Nicolas Pitre wrote:
>> On Wed, 9 Jan 2013, Arnd Bergmann wrote:
>>
>>> On a related topic, I still think we should fix ARCH_MULTI_V7 not
>>> to select ARCH_VEXPRESS unconditionally and come up with a better
>>> way to avoid having an empty platform list to make 'allnoconfig'
>>> still work.
>>
>> The virtual guest platform support that Will and Marc did is small 
>> enough that it could always be selected in place of vexpress.
> 
> But that only helps when ARMv7 is selected, unless we want to build
> it only for ARMv4, v5 or v6 kernels.
> 
> Besides, the only reason we can't have a kernel without any platform
> selected is that the linker script has code in it to intentionally
> barf on that because it's guaranteed not to boot on any hardware.
> 
> If we decide that building an allnoconfig without any platform
> is actually ok, we could just as well rip out that error statement.
> 

That patch is already posted, but Russell doesn't like it as you can
have a kernel that doesn't boot. You don't like the allno and randconfig
failures, so we're stuck. I think there are dozens of config options
that will make you not boot on any given platform, so failing to boot
because you did not select your machine is a non-issue.

Rob
