From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 Nov 2014 14:32:29 +0100
Subject: [PATCH] ARM: at91: remove useless init_time for DT-only SoCs
In-Reply-To: <20141120134615.0ebb3b83@bbrezillon>
References: <1415604709-24185-1-git-send-email-boris.brezillon@free-electrons.com>	<201411192323.34609.arnd@arndb.de>
 <20141120134615.0ebb3b83@bbrezillon>
Message-ID: <546DED6D.1000701@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/11/2014 13:46, Boris Brezillon :
> Hi Arnd,
> 
> On Wed, 19 Nov 2014 23:23:34 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Monday 10 November 2014, Boris Brezillon wrote:
>>> Hi Olof,
>>>
>>> You recently pulled some changes on Nicolas' at91-cleanup tag and two of
>>> those commits (see above for commit hashes) are actually introducing
>>> compilation errors.
>>> This patch fixes those compilation errors.
>>>
>>
>> Applied on next/cleanup, thanks!
> 
> Actually, I've made a v2 of this patch (see [1]) after realizing Olof
> had already fixed the initial compilation error.
> This is pretty much the same patch, except it removes asm/irq.h
> inclusion.
> 
> [1]http://thread.gmane.org/gmane.linux.ports.arm.kernel/370398

And this v2 was included in the pull-request I made and that Arnd have
just taken (at91-cleanup2 tag).

It seems that the files still have the "#include <asm/irq.h>" in the
result branch.

So, Arnd can whether remove the following commit (in next/cleanup):
440ae45119e9 (ARM: at91: remove useless init_time for DT-only SoCs)
or we can add another patch just to remove these additional lines.

Arnd, what do you prefer?

Bye,
-- 
Nicolas Ferre
