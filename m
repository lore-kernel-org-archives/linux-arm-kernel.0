From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Tue, 19 May 2015 10:49:20 -0400
Subject: [PATCH] xen: fix building on ARM with CONFIG_HIBERNATE_CALLBACKS
In-Reply-To: <2292282.A4UNIrHzbV@wuerfel>
References: <3837965.uXvcfKiP40@wuerfel> <555B413F.7020509@oracle.com>
 <2292282.A4UNIrHzbV@wuerfel>
Message-ID: <555B4D70.7050900@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 10:36 AM, Arnd Bergmann wrote:
> On Tuesday 19 May 2015 09:57:19 Boris Ostrovsky wrote:
>> On 05/19/2015 08:58 AM, Arnd Bergmann wrote:
>>> A recent bug fix for x86 broke Xen on ARM for the case that
>>> CONFIG_HIBERNATE_CALLBACKS is enabled:
>>>
>>> drivers/built-in.o: In function `do_suspend':
>>> /git/arm-soc/drivers/xen/manage.c:134: undefined reference to `xen_arch_suspend'
>>> drivers/built-in.o:(.debug_addr+0xc3f4): undefined reference to `xen_arch_suspend'
>>>
>>> It is not clear to me what needs to be done here, but this
>>> patch avoids the build error by adding a stub for the
>>> missing function.
>> This is already fixed in Xen staging tree.
> I see. Any chance to get that fix into linux-next soon?


David, are you going to send pull request to Linus before rc5?

-boris
