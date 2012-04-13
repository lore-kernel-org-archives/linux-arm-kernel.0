From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 13 Apr 2012 11:54:21 +0200
Subject: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
In-Reply-To: <20120413091828.GJ3168@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F87EBFC.90000@stericsson.com>
 <20120413091828.GJ3168@opensource.wolfsonmicro.com>
Message-ID: <4F87F7CD.4000004@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13/2012 11:18 AM, Mark Brown wrote:
> On Fri, Apr 13, 2012 at 11:03:56AM +0200, Ulf Hansson wrote:
>
>> But, how should those amba drivers that implements runtime PM
>> support be able to switch of the vcore regulator during normal
>> suspend? In normal suspend case we can not use
>
> A generic AMBA driver should have no idea about the implementation of
> the particular SoC that it's integrated on to.  This applies even more
> to system suspend (where drivers can generally just assume that they
> will loose all power normally) than it does to runtime suspend.
>
>> pm_runtime_put/pm_runtime_put_sync to trigger the power domain
>> runtime functions to switch of vcore. This is kind of more generic
>> problem when dealing with power domains, but as said this patch will
>> have consequences.
>
> The power domain gets callbacks on the system suspend path too and can
> do whatever is sensible there.
>
>> As far as I can see, the power domain must then implement a
>> suspend_noirq function to make sure same things is done as for the
>> runtime_suspend function. Do you agree with this as well or is there
>> another option?
>
> Yes, the power domain should just be handling this transparently.

Alright, thanks for your confirmation. Let's see how this works out then.

Kind regards
Ulf Hansson
