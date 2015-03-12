From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 Mar 2015 16:37:51 +0100
Subject: [PATCH 2/3] pm: at91: pm_slowclock: remove clocks which are
 already stopped when entering slow clock mode
In-Reply-To: <20150303225024.GA28292@gradator.net>
References: <1423115977-5852-1-git-send-email-wenyou.yang@atmel.com>
 <1423116083-5986-1-git-send-email-wenyou.yang@atmel.com>
 <54F60092.5070902@atmel.com> <20150303225024.GA28292@gradator.net>
Message-ID: <5501B2CF.1030809@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/03/2015 23:50, Sylvain Rochet a ?crit :
> Hello Nicolas,
> 
> On Tue, Mar 03, 2015 at 07:42:26PM +0100, Nicolas Ferre wrote:
>> Le 05/02/2015 07:01, Wenyou Yang a ?crit :
>>> From: Sylvain Rochet <sylvain.rochet@finsecur.com>
>>>
>>> Assume USB PLL and PLL B are already stopped before entering sleep mode,
>>> print a warning if this isn't the case.
>>>
>>> Removed PLL B from slow clock code, all drivers are supposed to properly
>>> unprepare clocks.
>>>
>>> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
>>> Acked-by: Wenyou.Yang <wenyou.yang@atmel.com>
>>
>> I keep this one for 4.1 as all the USB drivers are not converted yet.
> 
> I agree we should wait to prevent a regression, in case you missed that 
> I sent a v7 of my USBA PM support a few weeks ago (ping ;-).
> 

Sylvain, your series are in linux-next so I take this patch for 4.1 in
at91-4.1-cleanup with my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

But... I remove the arch/arm/mach-at91/pm.c part of this patch as it is
not really needed and adds a too strong dependency on the PMC in an
unrelated file...

Bye,
-- 
Nicolas Ferre
